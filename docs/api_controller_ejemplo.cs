// Este es el código que debes agregar a tu aplicación MVC en C#
// Controllers/SeleccionesEmocionesController.cs

using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;

namespace TuApp.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class SeleccionesEmocionesController : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        private readonly ILogger<SeleccionesEmocionesController> _logger;

        public SeleccionesEmocionesController(ApplicationDbContext context, ILogger<SeleccionesEmocionesController> logger)
        {
            _context = context;
            _logger = logger;
        }

        // POST: api/selecciones-emociones
        [HttpPost]
        public async Task<ActionResult<SeleccionEmocionResponse>> CrearSeleccion([FromBody] SeleccionEmocionRequest request)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }

                var seleccion = new SeleccionEmocion
                {
                    IdEmocion = request.IdEmocion,
                    NombreOriginal = request.NombreOriginal,
                    Intensidad = request.Intensidad,
                    Comentarios = request.Comentarios,
                    FechaSeleccion = request.FechaSeleccion,
                    Idioma = request.Idioma,
                    FechaCreacion = DateTime.UtcNow
                };

                _context.SeleccionesEmociones.Add(seleccion);
                await _context.SaveChangesAsync();

                _logger.LogInformation($"Selección creada con ID: {seleccion.Id}");

                return CreatedAtAction(nameof(ObtenerSeleccion), new { id = seleccion.Id }, 
                    new SeleccionEmocionResponse { Id = seleccion.Id });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error creando selección de emoción");
                return StatusCode(500, "Error interno del servidor");
            }
        }

        // GET: api/selecciones-emociones
        [HttpGet]
        public async Task<ActionResult<IEnumerable<SeleccionEmocionDto>>> ObtenerSelecciones(
            [FromQuery] int? limit = null,
            [FromQuery] string? idioma = null,
            [FromQuery] DateTime? fechaDesde = null,
            [FromQuery] DateTime? fechaHasta = null)
        {
            try
            {
                var query = _context.SeleccionesEmociones
                    .Include(s => s.Emocion)
                    .AsQueryable();

                if (!string.IsNullOrEmpty(idioma))
                {
                    query = query.Where(s => s.Idioma == idioma);
                }

                if (fechaDesde.HasValue)
                {
                    query = query.Where(s => s.FechaSeleccion >= fechaDesde.Value);
                }

                if (fechaHasta.HasValue)
                {
                    query = query.Where(s => s.FechaSeleccion <= fechaHasta.Value);
                }

                query = query.OrderByDescending(s => s.FechaSeleccion);

                if (limit.HasValue)
                {
                    query = query.Take(limit.Value);
                }

                var selecciones = await query.Select(s => new SeleccionEmocionDto
                {
                    Id = s.Id,
                    IdEmocion = s.IdEmocion,
                    NombreOriginal = s.NombreOriginal,
                    Intensidad = s.Intensidad,
                    Comentarios = s.Comentarios,
                    FechaSeleccion = s.FechaSeleccion,
                    Idioma = s.Idioma
                }).ToListAsync();

                return Ok(selecciones);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error obteniendo selecciones");
                return StatusCode(500, "Error interno del servidor");
            }
        }

        // GET: api/selecciones-emociones/{id}
        [HttpGet("{id}")]
        public async Task<ActionResult<SeleccionEmocionDto>> ObtenerSeleccion(int id)
        {
            try
            {
                var seleccion = await _context.SeleccionesEmociones
                    .Include(s => s.Emocion)
                    .FirstOrDefaultAsync(s => s.Id == id);

                if (seleccion == null)
                {
                    return NotFound();
                }

                var dto = new SeleccionEmocionDto
                {
                    Id = seleccion.Id,
                    IdEmocion = seleccion.IdEmocion,
                    NombreOriginal = seleccion.NombreOriginal,
                    Intensidad = seleccion.Intensidad,
                    Comentarios = seleccion.Comentarios,
                    FechaSeleccion = seleccion.FechaSeleccion,
                    Idioma = seleccion.Idioma
                };

                return Ok(dto);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"Error obteniendo selección {id}");
                return StatusCode(500, "Error interno del servidor");
            }
        }
    }

    // Controlador para estadísticas
    [ApiController]
    [Route("api/[controller]")]
    public class EstadisticasController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public EstadisticasController(ApplicationDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<EstadisticasDto>> ObtenerEstadisticas([FromQuery] string? idioma = null)
        {
            try
            {
                var query = _context.SeleccionesEmociones.AsQueryable();

                if (!string.IsNullOrEmpty(idioma))
                {
                    query = query.Where(s => s.Idioma == idioma);
                }

                var totalSelecciones = await query.CountAsync();

                var topEmociones = await query
                    .GroupBy(s => new { s.IdEmocion, s.Emocion.DescripcionEs, s.Emocion.DescripcionEn })
                    .Select(g => new TopEmocionDto
                    {
                        Id = g.Key.IdEmocion,
                        Descripcion = idioma == "es" ? g.Key.DescripcionEs : g.Key.DescripcionEn,
                        Cantidad = g.Count(),
                        IntensidadPromedio = g.Average(s => s.Intensidad)
                    })
                    .OrderByDescending(e => e.Cantidad)
                    .Take(5)
                    .ToListAsync();

                var estadisticas = new EstadisticasDto
                {
                    TotalSelecciones = totalSelecciones,
                    TopEmociones = topEmociones
                };

                return Ok(estadisticas);
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Error interno del servidor");
            }
        }
    }

    // Health check
    [ApiController]
    [Route("api/[controller]")]
    public class HealthController : ControllerBase
    {
        [HttpGet]
        public IActionResult Get()
        {
            return Ok(new { status = "OK", timestamp = DateTime.UtcNow });
        }
    }
}

// DTOs
public class SeleccionEmocionRequest
{
    [Required]
    public int IdEmocion { get; set; }
    
    [Required]
    [MaxLength(100)]
    public string NombreOriginal { get; set; }
    
    [Range(1, 10)]
    public int Intensidad { get; set; }
    
    [MaxLength(500)]
    public string? Comentarios { get; set; }
    
    [Required]
    public DateTime FechaSeleccion { get; set; }
    
    [Required]
    [MaxLength(5)]
    public string Idioma { get; set; }
}

public class SeleccionEmocionResponse
{
    public int Id { get; set; }
}

public class SeleccionEmocionDto
{
    public int Id { get; set; }
    public int IdEmocion { get; set; }
    public string NombreOriginal { get; set; }
    public int Intensidad { get; set; }
    public string? Comentarios { get; set; }
    public DateTime FechaSeleccion { get; set; }
    public string Idioma { get; set; }
}

public class EstadisticasDto
{
    public int TotalSelecciones { get; set; }
    public List<TopEmocionDto> TopEmociones { get; set; } = new();
}

public class TopEmocionDto
{
    public int Id { get; set; }
    public string Descripcion { get; set; }
    public int Cantidad { get; set; }
    public double IntensidadPromedio { get; set; }
}
