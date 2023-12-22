package com.algaworks.ecommerce.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.TableGenerator;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@EqualsAndHashCode
@Entity(name = "categorias")
public class Categoria {

  @Id
  @GeneratedValue(strategy = GenerationType.TABLE, generator = "tabela")
  @TableGenerator(name = "tabela", table = "hibernate_sequences", pkColumnName = "sequence_name",
      pkColumnValue = "categoria", valueColumnName = "next_val")
  private Long id;
  private String nome;
  @Column(name = "categoria_pai_id")
  private Long categoriaPaiId;
}
