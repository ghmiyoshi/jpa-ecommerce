package com.algaworks.ecommerce.mapeamentoavancado;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.models.NotaFiscal;
import com.algaworks.ecommerce.models.Pedido;
import java.io.IOException;
import java.time.LocalDateTime;
import org.junit.jupiter.api.Test;

class SalvandoArquivosTest extends EntityManagerTest {

  @Test
  void salvarXmlNota() {
    final var pedido = entityManager.find(Pedido.class, 1);

    final var notaFiscal = new NotaFiscal();
    notaFiscal.setPedido(pedido);
    notaFiscal.setDataEmissao(LocalDateTime.now());
    notaFiscal.setXml(carregarNotaFiscal());

    entityManager.getTransaction().begin();
    entityManager.persist(notaFiscal);
    entityManager.getTransaction().commit();

    final var notaFiscalVerificacao = entityManager.find(NotaFiscal.class, notaFiscal.getId());

    assertNotNull(notaFiscalVerificacao.getXml());
    assertTrue(notaFiscalVerificacao.getXml().length > 0);

    /*
        try {
            OutputStream out = new FileOutputStream(
                    Files.createFile(Paths.get(
                            System.getProperty("user.home") + "/xml.xml")).toFile());
            out.write(notaFiscalVerificacao.getXml());
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        */
  }

  private static byte[] carregarNotaFiscal() {
    try {
      return SalvandoArquivosTest.class.getResourceAsStream(
          "/nota-fiscal.xml").readAllBytes();
    } catch (IOException e) {
      throw new RuntimeException(e);
    }
  }
}
