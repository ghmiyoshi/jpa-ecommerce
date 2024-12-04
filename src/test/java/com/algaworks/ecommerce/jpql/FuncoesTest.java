package com.algaworks.ecommerce.jpql;

import static org.junit.jupiter.api.Assertions.assertFalse;

import com.algaworks.ecommerce.EntityManagerTest;
import org.junit.jupiter.api.Test;

class FuncoesTest extends EntityManagerTest {

    @Test
    void aplicarFuncao() {
        // concat, length, locate, substring, lower, upper, trim
        final var jpql = "select c.nome, length(c.nome) from Categoria c " +
                " where substring(c.nome, 1, 1) = 'i'";

        final var lista = entityManager.createQuery(jpql, Object[].class).getResultList();

        assertFalse(lista.isEmpty());
        lista.forEach(arr -> System.out.println(arr[0] + " - " + arr[1]));
    }

    @Test
    void aplicarFuncaoData() {
        // TimeZone.setDefault(TimeZone.getTimeZone("UTC"));
        // current_date, current_time, current_timestamp
        // year(p.dataCriacao), month(p.dataCriacao), day(p.dataCriacao)

        final var jpql = "select hour(p.dataCriacao), minute(p.dataCriacao), second(p.dataCriacao) "
                + " from Pedido p where hour(p.dataCriacao) > 0";

        final var lista = entityManager.createQuery(jpql, Object[].class).getResultList();

        assertFalse(lista.isEmpty());
        lista.forEach(arr -> System.out.println(arr[0] + " | " + arr[1] + " | " + arr[2]));
    }

    @Test
    void aplicarFuncaoNumero() {
        final var jpql = "select abs(p.total), mod(p.id, 2), sqrt(p.total) from Pedido p " +
                " where abs(p.total) > 900";

        final var lista = entityManager.createQuery(jpql, Object[].class).getResultList();

        assertFalse(lista.isEmpty());
        lista.forEach(arr -> System.out.println(arr[0] + " | " + arr[1] + " | " + arr[2]));
    }

    @Test
    void aplicarFuncaoColecao() {
        final var jpql = "select size(p.itens) from Pedido p where size(p.itens) >= 1";

        final var lista = entityManager.createQuery(jpql, Integer.class).getResultList();

        assertFalse(lista.isEmpty());
        lista.forEach(System.out::println);
    }
}
