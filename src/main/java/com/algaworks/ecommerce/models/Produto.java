package com.algaworks.ecommerce.models;

import com.algaworks.ecommerce.listeners.GenericoListener;
import jakarta.persistence.CollectionTable;
import jakarta.persistence.Column;
import jakarta.persistence.ElementCollection;
import jakarta.persistence.Entity;
import jakarta.persistence.EntityListeners;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.OneToOne;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@EqualsAndHashCode(of = "id")
@EntityListeners(GenericoListener.class)
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

  @OneToOne(mappedBy = "produto")
  private Estoque estoque;

  @Column(name = "data_criacao", updatable = false)
  private LocalDateTime dataCriacao;

  @Column(name = "data_ultima_atualizacao", insertable = false)
  private LocalDateTime dataUltimaAtualizacao;

  @ElementCollection
  @CollectionTable(name = "produtos_tags",
      joinColumns = @JoinColumn(name = "produto_id"))
  @Column(name = "tag")
  private List<String> tags;
}
