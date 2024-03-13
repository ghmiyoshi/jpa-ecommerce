package com.algaworks.ecommerce.mapeamentoavancado;

import static com.algaworks.ecommerce.models.SexoEnum.MASCULINO;
import static com.algaworks.ecommerce.models.StatusPagamentoEnum.PROCESSANDO;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.models.Cliente;
import com.algaworks.ecommerce.models.PagamentoCartao;
import com.algaworks.ecommerce.models.Pedido;
import java.time.LocalDate;
import org.junit.jupiter.api.Test;

class HerancaTest extends EntityManagerTest {

  @Test
  void salvarCliente() {
    final var cliente = new Cliente();
    cliente.setNome("Carlos Finotti");
    cliente.setSexo(MASCULINO);
    cliente.setCpf("12345678901");
    cliente.setDataNascimento(LocalDate.of(1990, 1, 1));

    entityManager.getTransaction().begin();
    entityManager.persist(cliente);
    entityManager.getTransaction().commit();

    entityManager.clear();

    final var clienteVerificacao = entityManager.find(Cliente.class, cliente.getId());

    assertNotNull(clienteVerificacao.getId());
  }

  @Test
  void buscarPagamentos() {
    final var pagamentos = entityManager
        .createQuery("SELECT p FROM Pagamento p")
        .getResultList();

    assertFalse(pagamentos.isEmpty());
    assertEquals(1, pagamentos.size());
  }

  @Test
  void incluirPagamentoPedido() {
    final var pedido = entityManager.find(Pedido.class, 2);

    final var pagamentoCartao = new PagamentoCartao();
    pagamentoCartao.setPedido(pedido);
    pagamentoCartao.setStatus(PROCESSANDO);
    pagamentoCartao.setNumeroCartao("123");
    pagamentoCartao.setNomeTitular("Carlos Finotti");

    entityManager.getTransaction().begin();
    entityManager.persist(pagamentoCartao);
    entityManager.getTransaction().commit();

    entityManager.clear();

    final var pedidoVerificacao = entityManager.find(Pedido.class, pedido.getId());

    assertNotNull(pedidoVerificacao.getPagamento());
  }
}
