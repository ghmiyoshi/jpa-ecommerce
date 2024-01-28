package com.algaworks.ecommerce.models;

import static java.util.Objects.nonNull;

import jakarta.persistence.CollectionTable;
import jakarta.persistence.Column;
import jakarta.persistence.ElementCollection;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.MapKeyColumn;
import jakarta.persistence.MapKeyEnumerated;
import jakarta.persistence.OneToMany;
import jakarta.persistence.PostLoad;
import jakarta.persistence.PrimaryKeyJoinColumn;
import jakarta.persistence.SecondaryTable;
import jakarta.persistence.Transient;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@EqualsAndHashCode(of = "id")
@SecondaryTable(name = "clientes_detalhes",
    pkJoinColumns = @PrimaryKeyJoinColumn(name = "cliente_id"))
@Entity(name = "clientes")
public class Cliente {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;
  private String nome;

  @Transient
  private String primeiroNome;

  @Column(table = "clientes_detalhes")
  @Enumerated(EnumType.STRING)
  private SexoEnum sexo;

  @Column(name = "data_nascimento", table = "clientes_detalhes")
  private LocalDate dataNascimento;
  @OneToMany(mappedBy = "cliente")
  private List<Pedido> pedidos;

  @ElementCollection
  @CollectionTable(name = "clientes_contatos",
      joinColumns = @JoinColumn(name = "cliente_id"))
  @Column(name = "numero")
  @MapKeyEnumerated(EnumType.STRING)
  @MapKeyColumn(name = "tipo")
  private Map<TipoContatoEnum, String> contatos;

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
