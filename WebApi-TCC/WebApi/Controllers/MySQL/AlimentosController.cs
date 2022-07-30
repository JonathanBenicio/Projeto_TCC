using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Model;
using Model.Context;
using System;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace WebApi.Controllers.MySQL
{
    [Route("v1/api/[controller]")]
    [ApiController]
    public class AlimentosController : ControllerBase
    {
        private readonly WebApiContextMySQL _context;

        private readonly IConfiguration _configuration;

        public AlimentosController(WebApiContextMySQL context, IConfiguration Configuration)
        {
            _configuration = Configuration;
            _context = context;
        }

        // GET: api/Alimentos
        [HttpGet]
        public async Task<ActionResult<dynamic>> GetAlimentos()
        {
            try
            {

                return await _context.Alimentos.Select(x => new
                {
                    x.Id,
                    x.Nome,
                    x.Marca,
                    x.Porcao_Tipo,
                    x.Porcao_Quantidade,
                    x.Porcao_Carboidratos,
                    x.Tipo,
                    x.Foto
                }).ToListAsync();
            }
            catch (Exception)
            {

                throw;
            }

        }

        // POST: api/Alimentos
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPost]
        public async Task<ActionResult<Alimento>> PostAlimento(Alimento alimento)
        {
            _context.Alimentos.Add(alimento);
            await _context.SaveChangesAsync();

            return Ok();
        }


        [HttpGet("{name}")]
        public ActionResult GetImagem(string id)
        {
            /*    string arquivoNome = "maca.jfif";
                //adiciona bytes ao memory stream   
                var dataStream = new MemoryStream(System.IO.File.ReadAllBytes(@"E:\Desktop\Aplicacao\WebApi-TCC\WebApi\wwwroot\Assets\Imagem\maca.jfif"));*/


            var stream = new FileStream(@"E:\Desktop\Aplicacao\WebApi-TCC\WebApi\wwwroot\Assets\Imagem\Atividade2.pdf", FileMode.Open);
            return File(stream, "application/pdf", "Atividade_2.pdf");


        }
    }
}
