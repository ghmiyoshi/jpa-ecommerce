package com.algaworks.ecommerce.models;

import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity(name = "estoques")
public class Estoque extends EntidadeBase {

  @OneToOne(optional = false)
  @JoinColumn(name = "produto_id")
  private Produto produto;
  private int quantidade;
}
