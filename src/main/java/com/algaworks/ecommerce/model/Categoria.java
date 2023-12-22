package com.algaworks.ecommerce.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@EqualsAndHashCode
@Entity(name = "categorias")
public class Categoria {

  @Id
  private Long id;
  private String nome;
  @Column(name = "categoria_pai_id")
  private Long categoriaPaiId;

}
