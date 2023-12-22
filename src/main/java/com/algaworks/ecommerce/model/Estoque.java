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
@Entity(name = "estoques")
public class Estoque {

  @Id
  private Long id;
  @Column(name = "produto_id")
  private Long produtoId;
  private int quantidade;

}
