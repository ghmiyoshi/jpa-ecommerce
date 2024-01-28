package com.algaworks.ecommerce.relacionamentos;

import static com.algaworks.ecommerce.models.StatusPagamentoEnum.PROCESSANDO;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.models.NotaFiscal;
import com.algaworks.ecommerce.models.PagamentoCartao;
import com.algaworks.ecommerce.models.Pedido;
import java.time.LocalDateTime;
import org.junit.jupiter.api.Test;

class RelacionamentosOneToOneTest extends EntityManagerTest {

  @Test
  void verificarRelacionamento() {
    final var pedido = entityManager.find(Pedido.class, 1L);

    final var pagamentoCartao = new PagamentoCartao();
    pagamentoCartao.setNumeroCartao("1234");
    pagamentoCartao.setStatus(PROCESSANDO);
    pagamentoCartao.setPedido(pedido);

    entityManager.getTransaction().begin();
    entityManager.persist(pagamentoCartao);
    entityManager.getTransaction().commit();
    entityManager.clear();

    final var pedidoVerificacao = entityManager.find(Pedido.class, pedido.getId());

    assertNotNull(pedidoVerificacao.getPagamento());
  }

  @Test
  void verificarRelacionamentoPedidoNotaFiscal() {
    final var pedido = entityManager.find(Pedido.class, 1L);

    final var notaFiscal = new NotaFiscal();
    notaFiscal.setDataEmissao(LocalDateTime.now());
    notaFiscal.setPedido(pedido);

    entityManager.getTransaction().begin();
    entityManager.persist(notaFiscal);
    entityManager.getTransaction().commit();
    entityManager.clear();

    final var pedidoVerificacao = entityManager.find(Pedido.class, pedido.getId());

    assertNotNull(pedidoVerificacao.getNotaFiscal());
  }
}
