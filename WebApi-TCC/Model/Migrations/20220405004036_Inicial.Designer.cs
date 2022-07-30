﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using Model.Context;

namespace Model.Migrations
{
    [DbContext(typeof(WebApiContextMySQL))]
    [Migration("20220405004036_Inicial")]
    partial class Inicial
    {
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("Relational:MaxIdentifierLength", 64)
                .HasAnnotation("ProductVersion", "5.0.10");

            modelBuilder.Entity("Model.Alimento", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<byte[]>("Foto")
                        .HasColumnType("longblob");

                    b.Property<string>("Marca")
                        .HasColumnType("longtext");

                    b.Property<string>("Nome")
                        .HasColumnType("longtext");

                    b.Property<double>("Porcao_Carboidratos")
                        .HasColumnType("double");

                    b.Property<double>("Porcao_Quantidade")
                        .HasColumnType("double");

                    b.Property<string>("Porcao_Tipo")
                        .HasColumnType("longtext");

                    b.Property<string>("Tipo")
                        .HasColumnType("longtext");

                    b.HasKey("Id");

                    b.ToTable("Alimentos");
                });

            modelBuilder.Entity("Model.Alimento_Historico", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<double>("Carboidratos_Total")
                        .HasColumnType("double");

                    b.Property<int>("Fk_Alimento_Id")
                        .HasColumnType("int");

                    b.Property<int>("Fk_Historico_Alimentar_Id")
                        .HasColumnType("int");

                    b.Property<double>("Quantidade")
                        .HasColumnType("double");

                    b.HasKey("Id");

                    b.HasIndex("Fk_Alimento_Id");

                    b.HasIndex("Fk_Historico_Alimentar_Id");

                    b.ToTable("Alimento_Historicos");
                });

            modelBuilder.Entity("Model.Historico_Alimentar", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<double>("Carboidratos_Insulina")
                        .HasColumnType("double");

                    b.Property<double>("Carboidratos_Total")
                        .HasColumnType("double");

                    b.Property<DateTime>("Data_Hora")
                        .HasColumnType("datetime(6)");

                    b.Property<int>("Fk_Paciente_Id")
                        .HasColumnType("int");

                    b.Property<int>("Fk_Tipo_Refeicao_Id")
                        .HasColumnType("int");

                    b.Property<double>("Glicemia_Alvo")
                        .HasColumnType("double");

                    b.Property<double>("Glicemia_Obtida")
                        .HasColumnType("double");

                    b.Property<double>("Insulina_Calculada")
                        .HasColumnType("double");

                    b.HasKey("Id");

                    b.HasIndex("Fk_Paciente_Id");

                    b.HasIndex("Fk_Tipo_Refeicao_Id");

                    b.ToTable("Historico_Alimentars");
                });

            modelBuilder.Entity("Model.Login", b =>
                {
                    b.Property<int?>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<string>("Email")
                        .HasColumnType("longtext");

                    b.Property<string>("Senha")
                        .HasColumnType("longtext");

                    b.HasKey("Id");

                    b.ToTable("Logins");
                });

            modelBuilder.Entity("Model.Nutricionista", b =>
                {
                    b.Property<int?>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<string>("Endereco")
                        .HasColumnType("longtext");

                    b.Property<int?>("Fk_Login_Id")
                        .HasColumnType("int");

                    b.Property<string>("Nome")
                        .HasColumnType("longtext");

                    b.Property<string>("Telefone")
                        .HasColumnType("longtext");

                    b.HasKey("Id");

                    b.HasIndex("Fk_Login_Id")
                        .IsUnique();

                    b.ToTable("Nutricionistas");
                });

            modelBuilder.Entity("Model.Paciente", b =>
                {
                    b.Property<int?>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<double>("Fator_Sensibilidade")
                        .HasColumnType("double");

                    b.Property<int?>("Fk_Login_Id")
                        .HasColumnType("int");

                    b.Property<int?>("Fk_Nutricionista_Id")
                        .HasColumnType("int");

                    b.Property<string>("Nome")
                        .HasColumnType("longtext");

                    b.Property<string>("Telefone")
                        .HasColumnType("longtext");

                    b.Property<int>("Tipo_Diabetes")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("Fk_Login_Id")
                        .IsUnique();

                    b.HasIndex("Fk_Nutricionista_Id");

                    b.ToTable("Pacientes");
                });

            modelBuilder.Entity("Model.Tipo_Refeicao", b =>
                {
                    b.Property<int?>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<int>("Fk_Paciente_Id")
                        .HasColumnType("int");

                    b.Property<double>("Glicemia_Alvo")
                        .HasColumnType("double");

                    b.Property<TimeSpan>("Horario")
                        .HasColumnType("time(6)");

                    b.Property<string>("Nome")
                        .HasColumnType("longtext");

                    b.HasKey("Id");

                    b.HasIndex("Fk_Paciente_Id");

                    b.ToTable("Tipo_Refeicaos");
                });

            modelBuilder.Entity("Model.Alimento_Historico", b =>
                {
                    b.HasOne("Model.Alimento", "Alimento")
                        .WithMany("Alimento_Historicos")
                        .HasForeignKey("Fk_Alimento_Id")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Model.Historico_Alimentar", "Historico_Alimentar")
                        .WithMany("Alimento_Historicos")
                        .HasForeignKey("Fk_Historico_Alimentar_Id")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Alimento");

                    b.Navigation("Historico_Alimentar");
                });

            modelBuilder.Entity("Model.Historico_Alimentar", b =>
                {
                    b.HasOne("Model.Paciente", "Paciente")
                        .WithMany("Historico_Alimentars")
                        .HasForeignKey("Fk_Paciente_Id")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Model.Tipo_Refeicao", "Tipo_Refeicao")
                        .WithMany("Historico_Alimentar")
                        .HasForeignKey("Fk_Tipo_Refeicao_Id")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Paciente");

                    b.Navigation("Tipo_Refeicao");
                });

            modelBuilder.Entity("Model.Nutricionista", b =>
                {
                    b.HasOne("Model.Login", "Login")
                        .WithOne("Nutricionista")
                        .HasForeignKey("Model.Nutricionista", "Fk_Login_Id");

                    b.Navigation("Login");
                });

            modelBuilder.Entity("Model.Paciente", b =>
                {
                    b.HasOne("Model.Login", "Login")
                        .WithOne("Paciente")
                        .HasForeignKey("Model.Paciente", "Fk_Login_Id");

                    b.HasOne("Model.Nutricionista", "Nutricionista")
                        .WithMany("Pacientes")
                        .HasForeignKey("Fk_Nutricionista_Id");

                    b.Navigation("Login");

                    b.Navigation("Nutricionista");
                });

            modelBuilder.Entity("Model.Tipo_Refeicao", b =>
                {
                    b.HasOne("Model.Paciente", "Paciente")
                        .WithMany("Tipo_Refeicaos")
                        .HasForeignKey("Fk_Paciente_Id")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Paciente");
                });

            modelBuilder.Entity("Model.Alimento", b =>
                {
                    b.Navigation("Alimento_Historicos");
                });

            modelBuilder.Entity("Model.Historico_Alimentar", b =>
                {
                    b.Navigation("Alimento_Historicos");
                });

            modelBuilder.Entity("Model.Login", b =>
                {
                    b.Navigation("Nutricionista");

                    b.Navigation("Paciente");
                });

            modelBuilder.Entity("Model.Nutricionista", b =>
                {
                    b.Navigation("Pacientes");
                });

            modelBuilder.Entity("Model.Paciente", b =>
                {
                    b.Navigation("Historico_Alimentars");

                    b.Navigation("Tipo_Refeicaos");
                });

            modelBuilder.Entity("Model.Tipo_Refeicao", b =>
                {
                    b.Navigation("Historico_Alimentar");
                });
#pragma warning restore 612, 618
        }
    }
}
