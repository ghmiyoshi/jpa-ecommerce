package com.algaworks.ecommerce.models;

import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import java.util.List;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity(name = "categorias")
public class Categoria extends EntidadeBase {

  private String nome;

  @ManyToOne
  @JoinColumn(name = "categoria_pai_id")
  private Categoria categoriaPai;

  @ManyToMany(mappedBy = "categorias")
  private List<Produto> produtos;

  @OneToMany(mappedBy = "categoriaPai")
  private List<Categoria> categorias;
}
