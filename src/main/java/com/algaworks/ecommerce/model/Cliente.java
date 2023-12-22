package com.algaworks.ecommerce.model;

import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Id;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@EqualsAndHashCode(of = "id")
@Entity(name = "clientes")
public class Cliente {

  @Id
  private Long id;
  private String nome;
  @Enumerated(EnumType.STRING)
  private SexoEnum sexo;
}
