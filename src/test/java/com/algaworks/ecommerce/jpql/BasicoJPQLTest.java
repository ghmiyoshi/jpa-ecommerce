package com.algaworks.ecommerce.jpql;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import com.algaworks.ecommerce.EntityManagerTest;
import com.algaworks.ecommerce.dto.ProdutoDTO;
import com.algaworks.ecommerce.models.Cliente;
import com.algaworks.ecommerce.models.Pedido;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;
import org.junit.jupiter.api.Test;

class BasicoJPQLTest extends EntityManagerTest {

    @Test
    void buscarPorIdentificador() {
        // entityManager.find(Pedido.class, 1)

        TypedQuery<Pedido> typedQuery = entityManager.createQuery("select p from Pedido p where p" +
                ".id = 2", Pedido.class);

        final var pedido = typedQuery.getSingleResult();
        assertNotNull(pedido);

        // List<Pedido> lista = typedQuery.getResultList();
        // assertFalse(lista.isEmpty());
    }

    @Test
    void mostrarDiferencaQueries() {
        String jpql = "select p from Pedido p where p.id = 2";

        TypedQuery<Pedido> typedQuery = entityManager.createQuery(jpql, Pedido.class);
        final var pedido1 = typedQuery.getSingleResult();
        assertNotNull(pedido1);

        Query query = entityManager.createQuery(jpql);
        Pedido pedido2 = (Pedido) query.getSingleResult();
        assertNotNull(pedido2);

        // List<Pedido> lista = query.getResultList();
        // assertFalse(lista.isEmpty());
    }

    @Test
    void selecionarUmAtributoParaRetorno() {
        final var jpql = "select p.nome from Produto p";
        final var lista = entityManager.createQuery(jpql, String.class).getResultList();

        assertEquals(String.class, lista.get(0).getClass());

        final var jpqlCliente = "select p.cliente from Pedido p";
        final var clientes = entityManager.createQuery(jpqlCliente,
                Cliente.class).getResultList();
        assertEquals(Cliente.class, clientes.get(0).getClass());
    }

    @Test
    void projetarResultado() {
        final var jpql = "select id, nome from Produto";
        final var result = entityManager.createQuery(jpql, Object[].class).getResultList();

        assertEquals(2, result.get(0).length);

        result.forEach(element -> System.out.println(element[0] + " - " + element[1]));
    }

    @Test
    void projetarNoDTO() {
        final var jpql = "select new com.algaworks.ecommerce.dto.ProdutoDTO(id, nome) from Produto";
        final var products = entityManager.createQuery(jpql, ProdutoDTO.class).getResultList();

        assertNotNull(products);

        products.forEach(produto -> System.out.println(produto.getId() + " - " + produto.getNome()));
    }

    @Test
    void ordenarResultados() {
        final var jpql = "select c from Cliente c order by c.nome asc"; // desc
        final var clientes = entityManager.createQuery(jpql, Cliente.class).getResultList();

        assertFalse(clientes.isEmpty());

        clientes.forEach(c -> System.out.println(c.getId() + ", " + c.getNome()));
    }
}