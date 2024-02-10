package com.algaworks.ecommerce.models;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.ForeignKey;
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

  @Column(length = 100, nullable = false)
  private String nome;

  @ManyToOne
  @JoinColumn(name = "categoria_pai_id",
      foreignKey = @ForeignKey(name = "fk_categorias_categoria_pai"))
  private Categoria categoriaPai;

  @ManyToMany(mappedBy = "categorias")
  private List<Produto> produtos;

  @OneToMany(mappedBy = "categoriaPai")
  private List<Categoria> categorias;
}
