package com.algaworks.ecommerce.conhecendoentitymanager;

import static com.algaworks.ecommerce.models.StatusPedidoEnum.PAGO;
import static java.util.Objects.isNull;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.models.Pedido;
import org.junit.jupiter.api.Test;

class GerenciamentoTransacoesTest extends EntityManagerTest {

  @Test
  void abrirFecharCancelarTransacao() {
    try {
      entityManager.getTransaction().begin();
      final var exception = assertThrows(Exception.class,
          GerenciamentoTransacoesTest::metodoDeNegocio);
      assertEquals("Pedido ainda não foi pago.", exception.getMessage());
      entityManager.getTransaction().commit();
    } catch (Exception e) {
      entityManager.getTransaction().rollback();
    }
  }

  private static void metodoDeNegocio() {
    final var pedido = entityManager.find(Pedido.class, 1L);
    pedido.setStatus(PAGO);

    if (isNull(pedido.getPagamentoCartao())) {
      throw new RuntimeException("Pedido ainda não foi pago.");
    }
  }
}
