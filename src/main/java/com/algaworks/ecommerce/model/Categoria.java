package com.algaworks.ecommerce.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.SequenceGenerator;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@EqualsAndHashCode
@Entity(name = "categorias")
public class Categoria {

  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq")
  @SequenceGenerator(name = "seq", sequenceName = "sequencias_chave_primaria")
  private Long id;
  private String nome;
  @Column(name = "categoria_pai_id")
  private Long categoriaPaiId;
}
