# Configuración de CORS para la API

Para que tu app Flutter pueda conectarse a tu API desde cualquier dispositivo, necesitas configurar CORS en tu aplicación MVC.

## 1. En tu archivo Startup.cs o Program.cs (dependiendo de la versión de .NET):

```csharp
public void ConfigureServices(IServiceCollection services)
{
    // Configuración de CORS
    services.AddCors(options =>
    {
        options.AddPolicy("AllowFlutterApp",
            builder => builder
                .AllowAnyOrigin()
                .AllowAnyMethod()
                .AllowAnyHeader());
    });

    services.AddControllers();
    services.AddDbContext<ApplicationDbContext>(options =>
        options.UseSqlServer(connectionString));
}

public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
{
    if (env.IsDevelopment())
    {
        app.UseDeveloperExceptionPage();
    }

    app.UseRouting();
    
    // Usar CORS
    app.UseCors("AllowFlutterApp");
    
    app.UseEndpoints(endpoints =>
    {
        endpoints.MapControllers();
    });
}
```

## 2. Para .NET 6+ en Program.cs:

```csharp
var builder = WebApplication.CreateBuilder(args);

// Configurar CORS
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowFlutterApp",
        policy => policy
            .AllowAnyOrigin()
            .AllowAnyMethod()
            .AllowAnyHeader());
});

builder.Services.AddControllers();
builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlServer(connectionString));

var app = builder.Build();

// Usar CORS
app.UseCors("AllowFlutterApp");

app.UseRouting();
app.MapControllers();

app.Run();
```

## 3. Configuración de la base URL en la app Flutter

Actualiza el archivo de configuración para que apunte a tu servidor:

```dart
// En lib/services/api_service.dart, línea 7:
// Cambia 'http://tu-servidor.com' por la URL real de tu API
static const String _baseUrl = 'https://tu-dominio.com/api';
```

## 4. Publicación de la API

Para que tu app móvil pueda acceder a la API:

1. **Desarrollo local**: Usa tu IP local (ej: `http://192.168.1.100:5000/api`)
2. **Producción**: Publica tu API en un servidor web (IIS, Azure, etc.)

## 5. Configuración de SSL/HTTPS

Para producción, asegúrate de:
- Usar HTTPS (certificado SSL)
- Configurar el puerto correcto
- Permitir conexiones externas en el firewall

## 6. Probar la API

Puedes probar los endpoints con herramientas como:
- Postman
- curl
- Swagger (si lo tienes configurado)

Ejemplo de prueba:
```bash
curl -X GET "https://tu-dominio.com/api/health" -H "accept: application/json"
```
