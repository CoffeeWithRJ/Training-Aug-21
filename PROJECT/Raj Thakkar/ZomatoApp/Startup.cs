using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.IdentityModel.Tokens;
using ZomatoApp.Authentication;
using ZomatoApp.Models;
using ZomatoApp.Repository;
using ZomatoApp.Repository.Interfaces;

namespace ZomatoApp
{
    public class Startup
    {
        // This method gets called by the runtime. Use this method to add services to the container.
        // For more information on how to configure your application, visit https://go.microsoft.com/fwlink/?LinkID=398940
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddCors(options =>
            {
                options.AddPolicy(name: "policy1",
                builder =>
                {
                    builder.AllowAnyOrigin()
    .AllowAnyMethod()
    .AllowAnyHeader();
                });
            });
            services.AddControllers();
            //services.AddDbContext<ZomatoApp_ProjectContext>(options => options.UseSqlServer("Server=PC0610\\MSSQL2019;Database=WebAPIZomato;Integrated Security=True"));
            // For Entity Framework  
            IServiceCollection serviceCollection = services.AddDbContext<ApplicationDbContext>(options => options.UseSqlServer(Configuration.GetConnectionString("ZomatoAppDB")));
           
            // For Identity  
            services.AddIdentity<ApplicationUser, IdentityRole>()
                .AddEntityFrameworkStores<ApplicationDbContext>()
                .AddDefaultTokenProviders();

            // Adding Authentication  
            services.AddAuthentication(options =>
            {
                options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
                options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
                options.DefaultScheme = JwtBearerDefaults.AuthenticationScheme;
            })

            // Adding Jwt Bearer  
            .AddJwtBearer(options =>
            {
                options.SaveToken = true;
                options.RequireHttpsMetadata = false;
                options.TokenValidationParameters = new TokenValidationParameters()
                {
                    ValidateIssuer = true,
                    ValidateAudience = true,
                    ValidAudience = Configuration["JWT:ValidAudience"],
                    ValidIssuer = Configuration["JWT:ValidIssuer"],
                    IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(Configuration["JWT:Secret"]))
                };
            });
            services.AddTransient<ICategory, RCategory>();
         
            services.AddTransient<IOffer, ROffer>();
            services.AddTransient<IOrder, ROrder>();
            services.AddTransient<IOrderStatus, ROrderStatus>();
            services.AddTransient<IPayment, RPayment>();
            services.AddTransient<IProduct, RProduct>();
            services.AddTransient<IQuote, RQuote>();
            services.AddTransient<IRestaurant, RRestaurant>();
            services.AddTransient<IViewProduct, RViewProduct>();
            services.AddTransient<IProduct, RProduct>();
            services.AddTransient<IUserSignup, RUserSignup>();
            services.AddTransient<ICity, RCity>();
            
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseRouting();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapGet("/", async context =>
                {
                    await context.Response.WriteAsync("Hello World!");
                });
            });
        }
    }
}
