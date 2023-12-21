package com.algaworks.ecommerce;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;

class EntityManagerTest {

  private static EntityManagerFactory entityManagerFactory;
  protected static EntityManager entityManager;

  @BeforeAll
  static void setUpBeforeClass() {
    entityManagerFactory = Persistence.createEntityManagerFactory("Ecommerce-PU");
    entityManager = entityManagerFactory.createEntityManager();
  }

  @AfterAll
  static void tearDownAfterClass() {
    entityManager.close();
    entityManagerFactory.close();
  }
}
