package com.algaworks.ecommerce.models;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import java.math.BigDecimal;
import java.util.List;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@EqualsAndHashCode(of = "id")
@Entity(name = "produtos")
public class Produto {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;
  private String nome;
  private String descricao;
  private BigDecimal preco;

  @ManyToMany
  @JoinTable(name = "produtos_categorias", joinColumns = @JoinColumn(name = "produto_id"),
      inverseJoinColumns = @JoinColumn(name = "categoria_id"))
  private List<Categoria> categorias;
}
