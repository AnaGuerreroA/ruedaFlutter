# Modelos de Base de Datos para SQL Server

Estos son los modelos que necesitas crear en tu aplicación MVC para Entity Framework.

## 1. Modelo de Emoción

```csharp
// Models/Emocion.cs
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

[Table("Emociones")]
public class Emocion
{
    [Key]
    public int Id { get; set; }
    
    [Required]
    [MaxLength(100)]
    public string DescripcionEs { get; set; }
    
    [Required]
    [MaxLength(100)]
    public string DescripcionEn { get; set; }
    
    [Required]
    public int Nivel { get; set; }
    
    public int? IdPadre { get; set; }
    
    [ForeignKey("IdPadre")]
    public virtual Emocion? EmocioPadre { get; set; }
    
    public virtual ICollection<Emocion> EmocionesHijas { get; set; } = new List<Emocion>();
    
    public virtual ICollection<SeleccionEmocion> Selecciones { get; set; } = new List<SeleccionEmocion>();
    
    public DateTime FechaCreacion { get; set; } = DateTime.UtcNow;
}
```

## 2. Modelo de Selección de Emoción

```csharp
// Models/SeleccionEmocion.cs
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

[Table("SeleccionesEmociones")]
public class SeleccionEmocion
{
    [Key]
    public int Id { get; set; }
    
    [Required]
    public int IdEmocion { get; set; }
    
    [ForeignKey("IdEmocion")]
    public virtual Emocion Emocion { get; set; }
    
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
    
    public DateTime FechaCreacion { get; set; } = DateTime.UtcNow;
}
```

## 3. Contexto de Base de Datos

```csharp
// Data/ApplicationDbContext.cs
using Microsoft.EntityFrameworkCore;

public class ApplicationDbContext : DbContext
{
    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
        : base(options)
    {
    }

    public DbSet<Emocion> Emociones { get; set; }
    public DbSet<SeleccionEmocion> SeleccionesEmociones { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        // Configuración de Emocion
        modelBuilder.Entity<Emocion>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.DescripcionEs).IsRequired().HasMaxLength(100);
            entity.Property(e => e.DescripcionEn).IsRequired().HasMaxLength(100);
            entity.Property(e => e.Nivel).IsRequired();
            
            // Relación padre-hijo
            entity.HasOne(e => e.EmocioPadre)
                  .WithMany(e => e.EmocionesHijas)
                  .HasForeignKey(e => e.IdPadre)
                  .OnDelete(DeleteBehavior.Restrict);
        });

        // Configuración de SeleccionEmocion
        modelBuilder.Entity<SeleccionEmocion>(entity =>
        {
            entity.HasKey(s => s.Id);
            entity.Property(s => s.NombreOriginal).IsRequired().HasMaxLength(100);
            entity.Property(s => s.Intensidad).IsRequired();
            entity.Property(s => s.FechaSeleccion).IsRequired();
            entity.Property(s => s.Idioma).IsRequired().HasMaxLength(5);
            entity.Property(s => s.Comentarios).HasMaxLength(500);
            
            // Relación con Emocion
            entity.HasOne(s => s.Emocion)
                  .WithMany(e => e.Selecciones)
                  .HasForeignKey(s => s.IdEmocion)
                  .OnDelete(DeleteBehavior.Cascade);
        });

        // Datos iniciales de emociones (seed data)
        SeedEmociones(modelBuilder);
    }

    private void SeedEmociones(ModelBuilder modelBuilder)
    {
        // Emociones primarias (Nivel 1)
        modelBuilder.Entity<Emocion>().HasData(
            new Emocion { Id = 1, DescripcionEs = "Alegría", DescripcionEn = "Joy", Nivel = 1 },
            new Emocion { Id = 2, DescripcionEs = "Tristeza", DescripcionEn = "Sadness", Nivel = 1 },
            new Emocion { Id = 3, DescripcionEs = "Ira", DescripcionEn = "Anger", Nivel = 1 },
            new Emocion { Id = 4, DescripcionEs = "Miedo", DescripcionEn = "Fear", Nivel = 1 },
            new Emocion { Id = 5, DescripcionEs = "Sorpresa", DescripcionEn = "Surprise", Nivel = 1 },
            new Emocion { Id = 6, DescripcionEs = "Asco", DescripcionEn = "Disgust", Nivel = 1 }
        );

        // Aquí puedes agregar todas las 130 emociones de tu archivo emotions.json
        // Para mantener este ejemplo corto, solo incluyo algunas emociones secundarias:
        
        modelBuilder.Entity<Emocion>().HasData(
            // Emociones de Alegría (Nivel 2)
            new Emocion { Id = 11, DescripcionEs = "Éxtasis", DescripcionEn = "Ecstasy", Nivel = 2, IdPadre = 1 },
            new Emocion { Id = 12, DescripcionEs = "Admiración", DescripcionEn = "Admiration", Nivel = 2, IdPadre = 1 },
            new Emocion { Id = 13, DescripcionEs = "Vigilancia", DescripcionEn = "Vigilance", Nivel = 2, IdPadre = 1 },
            
            // Emociones de Tristeza (Nivel 2)
            new Emocion { Id = 21, DescripcionEs = "Dolor", DescripcionEn = "Grief", Nivel = 2, IdPadre = 2 },
            new Emocion { Id = 22, DescripcionEs = "Decepción", DescripcionEn = "Disappointment", Nivel = 2, IdPadre = 2 },
            new Emocion { Id = 23, DescripcionEs = "Pena", DescripcionEn = "Sorrow", Nivel = 2, IdPadre = 2 }
        );
        
        // Continúa agregando el resto de las emociones...
    }
}
```

## 4. Script SQL para crear las tablas manualmente (opcional)

```sql
-- Crear tabla Emociones
CREATE TABLE Emociones (
    Id int IDENTITY(1,1) PRIMARY KEY,
    DescripcionEs nvarchar(100) NOT NULL,
    DescripcionEn nvarchar(100) NOT NULL,
    Nivel int NOT NULL,
    IdPadre int NULL,
    FechaCreacion datetime2 NOT NULL DEFAULT GETUTCDATE(),
    FOREIGN KEY (IdPadre) REFERENCES Emociones(Id)
);

-- Crear tabla SeleccionesEmociones
CREATE TABLE SeleccionesEmociones (
    Id int IDENTITY(1,1) PRIMARY KEY,
    IdEmocion int NOT NULL,
    NombreOriginal nvarchar(100) NOT NULL,
    Intensidad int NOT NULL CHECK (Intensidad >= 1 AND Intensidad <= 10),
    Comentarios nvarchar(500) NULL,
    FechaSeleccion datetime2 NOT NULL,
    Idioma nvarchar(5) NOT NULL,
    FechaCreacion datetime2 NOT NULL DEFAULT GETUTCDATE(),
    FOREIGN KEY (IdEmocion) REFERENCES Emociones(Id) ON DELETE CASCADE
);

-- Crear índices para mejor rendimiento
CREATE INDEX IX_SeleccionesEmociones_IdEmocion ON SeleccionesEmociones(IdEmocion);
CREATE INDEX IX_SeleccionesEmociones_FechaSeleccion ON SeleccionesEmociones(FechaSeleccion);
CREATE INDEX IX_SeleccionesEmociones_Idioma ON SeleccionesEmociones(Idioma);
```

## 5. Comandos de Migración de Entity Framework

Una vez que tengas los modelos, ejecuta estos comandos en la consola de Package Manager:

```bash
# Crear la migración inicial
Add-Migration InitialCreate

# Aplicar la migración a la base de datos
Update-Database
```

O si prefieres usar .NET CLI:

```bash
# Crear la migración inicial
dotnet ef migrations add InitialCreate

# Aplicar la migración a la base de datos
dotnet ef database update
```
