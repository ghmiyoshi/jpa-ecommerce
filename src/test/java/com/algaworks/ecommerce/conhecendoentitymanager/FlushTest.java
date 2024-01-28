package com.algaworks.ecommerce.conhecendoentitymanager;

import static com.algaworks.ecommerce.models.StatusPedidoEnum.PAGO;
import static java.util.Objects.isNull;
import static org.junit.jupiter.api.Assertions.assertThrows;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.models.Pedido;
import org.junit.jupiter.api.Test;

class FlushTest extends EntityManagerTest {

  @Test
  void chamarFlush() {
    assertThrows(Exception.class, FlushTest::erroAoChamarFlush);
  }

  private static void erroAoChamarFlush() {
    try {
      entityManager.getTransaction().begin();

      final var pedido = entityManager.find(Pedido.class, 1);
      pedido.setStatus(PAGO);

      entityManager.flush();

      if (isNull(pedido.getPagamento())) {
        throw new RuntimeException("Pedido ainda não foi pago.");
      }

//            Uma consulta obriga o JPA a sincronizar o que ele tem na memória (sem usar o flush explicitamente).
//            Pedido pedidoPago = entityManager
//                    .createQuery("select p from Pedido p where p.id = 1", Pedido.class)
//                    .getSingleResult();
//            Assertions.assertEquals(pedido.getStatus(), pedidoPago.getStatus());

      entityManager.getTransaction().commit();
    } catch (Exception e) {
      entityManager.getTransaction().rollback();
      throw e;
    }
  }
}
