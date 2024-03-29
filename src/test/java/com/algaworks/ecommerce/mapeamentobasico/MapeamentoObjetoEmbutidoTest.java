package com.algaworks.ecommerce.mapeamentobasico;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.models.Cliente;
import com.algaworks.ecommerce.models.Endereco;
import com.algaworks.ecommerce.models.Pedido;
import com.algaworks.ecommerce.models.StatusPedidoEnum;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import org.junit.jupiter.api.Test;

class MapeamentoObjetoEmbutidoTest extends EntityManagerTest {

  @Test
  void analisarMapeamentoObjetoEmbutido() {
    final var endereco = new Endereco();
    endereco.setCep("00000-00");
    endereco.setLogradouro("Rua das Laranjeiras");
    endereco.setNumero("123");
    endereco.setBairro("Centro");
    endereco.setCidade("Uberlândia");
    endereco.setEstado("MG");

    final var pedido = new Pedido();
    pedido.setDataPedido(LocalDateTime.now());
    pedido.setStatus(StatusPedidoEnum.AGUARDANDO);
    pedido.setTotal(new BigDecimal(1000));
    pedido.setEnderecoEntrega(endereco);

    final var cliente = new Cliente();
    cliente.setNome("Fernando Medeiros");
    cliente.setCpf("12345678901");

    pedido.setCliente(cliente);
    entityManager.getTransaction().begin();
    entityManager.persist(cliente);
    entityManager.persist(pedido);
    entityManager.getTransaction().commit();
    entityManager.clear();

    final var pedidoVerificacao = entityManager.find(Pedido.class, pedido.getId());

    assertNotNull(pedidoVerificacao);
    assertNotNull(pedidoVerificacao.getEnderecoEntrega());
    assertNotNull(pedidoVerificacao.getEnderecoEntrega().getCep());
  }
}
