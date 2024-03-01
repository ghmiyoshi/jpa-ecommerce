package com.algaworks.ecommerce.models;

import com.algaworks.ecommerce.listeners.GenericoListener;
import jakarta.persistence.CascadeType;
import jakarta.persistence.CollectionTable;
import jakarta.persistence.Column;
import jakarta.persistence.ElementCollection;
import jakarta.persistence.Entity;
import jakarta.persistence.EntityListeners;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Index;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.Lob;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import java.math.BigDecimal;
import java.util.List;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@EntityListeners(GenericoListener.class)
@Entity
@Table(name = "produtos", uniqueConstraints =
@UniqueConstraint(name = "unq_nome", columnNames = "nome"),
    indexes = @Index(name = "idx_nome", columnList = "nome"))
public class Produto extends EntidadeBase {

  @Column(length = 100, nullable = false, unique = true)
  private String nome;

  @Column(columnDefinition = "varchar(275) not null default 'descricao'")
  private String descricao;

  private BigDecimal preco;

  @ManyToMany(cascade = CascadeType.PERSIST)
  @JoinTable(name = "produtos_categorias",
      joinColumns = @JoinColumn(name = "produto_id", nullable = false,
          foreignKey = @ForeignKey(name = "fk_produtos_categorias_produto")),
      inverseJoinColumns = @JoinColumn(name = "categoria_id", nullable = false,
          foreignKey = @ForeignKey(name = "fk_produtos_categorias_categoria")))
  private List<Categoria> categorias;

  @OneToOne(mappedBy = "produto")
  private Estoque estoque;

  @ElementCollection
  @CollectionTable(name = "produtos_tags",
      joinColumns = @JoinColumn(name = "produto_id"))
  @Column(name = "tag", length = 50, nullable = false)
  private List<String> tags;

  @ElementCollection
  @CollectionTable(name = "produtos_atributos",
      joinColumns = @JoinColumn(name = "produto_id"))
  private List<Atributo> atributos;

  @Lob
  @Column(length = 1000)
  private byte[] foto;
}
