package com.algaworks.ecommerce.models;

import static java.util.Objects.nonNull;

import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.PostLoad;
import jakarta.persistence.Transient;
import java.util.List;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@EqualsAndHashCode(of = "id")
@Entity(name = "clientes")
public class Cliente {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;
  private String nome;

  @Transient
  private String primeiroNome;

  @Enumerated(EnumType.STRING)
  private SexoEnum sexo;
  @OneToMany(mappedBy = "cliente")
  private List<Pedido> pedidos;

  @PostLoad
  public void configurarPrimeiroNome() {
    if (nonNull(nome) && !nome.isBlank()) {
      int index = nome.indexOf(" ");
      if (index > -1) {
        primeiroNome = nome.substring(0, index);
      }
    }
  }
}
