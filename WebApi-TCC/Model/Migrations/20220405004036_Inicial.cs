using System;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

namespace Model.Migrations
{
    public partial class Inicial : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterDatabase()
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "Alimentos",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    Nome = table.Column<string>(type: "longtext", nullable: true)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Marca = table.Column<string>(type: "longtext", nullable: true)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Porcao_Tipo = table.Column<string>(type: "longtext", nullable: true)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Porcao_Quantidade = table.Column<double>(type: "double", nullable: false),
                    Porcao_Carboidratos = table.Column<double>(type: "double", nullable: false),
                    Tipo = table.Column<string>(type: "longtext", nullable: true)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Foto = table.Column<byte[]>(type: "longblob", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Alimentos", x => x.Id);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "Logins",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    Email = table.Column<string>(type: "longtext", nullable: true)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Senha = table.Column<string>(type: "longtext", nullable: true)
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Logins", x => x.Id);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "Nutricionistas",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    Endereco = table.Column<string>(type: "longtext", nullable: true)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Nome = table.Column<string>(type: "longtext", nullable: true)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Telefone = table.Column<string>(type: "longtext", nullable: true)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Fk_Login_Id = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Nutricionistas", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Nutricionistas_Logins_Fk_Login_Id",
                        column: x => x.Fk_Login_Id,
                        principalTable: "Logins",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "Pacientes",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    Fator_Sensibilidade = table.Column<double>(type: "double", nullable: false),
                    Tipo_Diabetes = table.Column<int>(type: "int", nullable: false),
                    Fk_Nutricionista_Id = table.Column<int>(type: "int", nullable: true),
                    Nome = table.Column<string>(type: "longtext", nullable: true)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Telefone = table.Column<string>(type: "longtext", nullable: true)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Fk_Login_Id = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Pacientes", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Pacientes_Logins_Fk_Login_Id",
                        column: x => x.Fk_Login_Id,
                        principalTable: "Logins",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_Pacientes_Nutricionistas_Fk_Nutricionista_Id",
                        column: x => x.Fk_Nutricionista_Id,
                        principalTable: "Nutricionistas",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "Tipo_Refeicaos",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    Nome = table.Column<string>(type: "longtext", nullable: true)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Horario = table.Column<TimeSpan>(type: "time(6)", nullable: false),
                    Glicemia_Alvo = table.Column<double>(type: "double", nullable: false),
                    Fk_Paciente_Id = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Tipo_Refeicaos", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Tipo_Refeicaos_Pacientes_Fk_Paciente_Id",
                        column: x => x.Fk_Paciente_Id,
                        principalTable: "Pacientes",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "Historico_Alimentars",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    Glicemia_Obtida = table.Column<double>(type: "double", nullable: false),
                    Glicemia_Alvo = table.Column<double>(type: "double", nullable: false),
                    Carboidratos_Total = table.Column<double>(type: "double", nullable: false),
                    Carboidratos_Insulina = table.Column<double>(type: "double", nullable: false),
                    Insulina_Calculada = table.Column<double>(type: "double", nullable: false),
                    Data_Hora = table.Column<DateTime>(type: "datetime(6)", nullable: false),
                    Fk_Tipo_Refeicao_Id = table.Column<int>(type: "int", nullable: false),
                    Fk_Paciente_Id = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Historico_Alimentars", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Historico_Alimentars_Pacientes_Fk_Paciente_Id",
                        column: x => x.Fk_Paciente_Id,
                        principalTable: "Pacientes",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Historico_Alimentars_Tipo_Refeicaos_Fk_Tipo_Refeicao_Id",
                        column: x => x.Fk_Tipo_Refeicao_Id,
                        principalTable: "Tipo_Refeicaos",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "Alimento_Historicos",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    Quantidade = table.Column<double>(type: "double", nullable: false),
                    Carboidratos_Total = table.Column<double>(type: "double", nullable: false),
                    Fk_Alimento_Id = table.Column<int>(type: "int", nullable: false),
                    Fk_Historico_Alimentar_Id = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Alimento_Historicos", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Alimento_Historicos_Alimentos_Fk_Alimento_Id",
                        column: x => x.Fk_Alimento_Id,
                        principalTable: "Alimentos",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Alimento_Historicos_Historico_Alimentars_Fk_Historico_Alimen~",
                        column: x => x.Fk_Historico_Alimentar_Id,
                        principalTable: "Historico_Alimentars",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateIndex(
                name: "IX_Alimento_Historicos_Fk_Alimento_Id",
                table: "Alimento_Historicos",
                column: "Fk_Alimento_Id");

            migrationBuilder.CreateIndex(
                name: "IX_Alimento_Historicos_Fk_Historico_Alimentar_Id",
                table: "Alimento_Historicos",
                column: "Fk_Historico_Alimentar_Id");

            migrationBuilder.CreateIndex(
                name: "IX_Historico_Alimentars_Fk_Paciente_Id",
                table: "Historico_Alimentars",
                column: "Fk_Paciente_Id");

            migrationBuilder.CreateIndex(
                name: "IX_Historico_Alimentars_Fk_Tipo_Refeicao_Id",
                table: "Historico_Alimentars",
                column: "Fk_Tipo_Refeicao_Id");

            migrationBuilder.CreateIndex(
                name: "IX_Nutricionistas_Fk_Login_Id",
                table: "Nutricionistas",
                column: "Fk_Login_Id",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Pacientes_Fk_Login_Id",
                table: "Pacientes",
                column: "Fk_Login_Id",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Pacientes_Fk_Nutricionista_Id",
                table: "Pacientes",
                column: "Fk_Nutricionista_Id");

            migrationBuilder.CreateIndex(
                name: "IX_Tipo_Refeicaos_Fk_Paciente_Id",
                table: "Tipo_Refeicaos",
                column: "Fk_Paciente_Id");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Alimento_Historicos");

            migrationBuilder.DropTable(
                name: "Alimentos");

            migrationBuilder.DropTable(
                name: "Historico_Alimentars");

            migrationBuilder.DropTable(
                name: "Tipo_Refeicaos");

            migrationBuilder.DropTable(
                name: "Pacientes");

            migrationBuilder.DropTable(
                name: "Nutricionistas");

            migrationBuilder.DropTable(
                name: "Logins");
        }
    }
}
