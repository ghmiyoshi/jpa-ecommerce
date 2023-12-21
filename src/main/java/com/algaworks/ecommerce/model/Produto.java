package com.algaworks.ecommerce.model;

import static java.util.Objects.hash;
import static java.util.Objects.isNull;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import java.math.BigDecimal;
import java.util.Objects;

@Entity(name = "produto")
public class Produto {

  @Id
  private Long id;
  private String nome;
  private String descricao;
  private BigDecimal preco;

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public void setNome(String nome) {
    this.nome = nome;
  }

  public String getNome() {
    return nome;
  }

  public String getDescricao() {
    return descricao;
  }

  public void setDescricao(String descricao) {
    this.descricao = descricao;
  }

  public BigDecimal getPreco() {
    return preco;
  }

  public void setPreco(BigDecimal preco) {
    this.preco = preco;
  }

  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (isNull(o) || getClass() != o.getClass()) {
      return false;
    }
    Produto produto = (Produto) o;
    return Objects.equals(id, produto.id);
  }

  @Override
  public int hashCode() {
    return hash(id);
  }
}
