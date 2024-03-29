package com.algaworks.ecommerce.models;

import static java.util.Objects.nonNull;

import jakarta.persistence.CollectionTable;
import jakarta.persistence.Column;
import jakarta.persistence.ElementCollection;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Index;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.MapKeyColumn;
import jakarta.persistence.MapKeyEnumerated;
import jakarta.persistence.OneToMany;
import jakarta.persistence.PostLoad;
import jakarta.persistence.PrimaryKeyJoinColumn;
import jakarta.persistence.SecondaryTable;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import jakarta.persistence.UniqueConstraint;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@SecondaryTable(name = "clientes_detalhes",
    pkJoinColumns = @PrimaryKeyJoinColumn(name = "cliente_id"),
    foreignKey = @ForeignKey(name = "fk_clientes_detalhes_clientes"))
@Entity
@Table(name = "clientes", uniqueConstraints =
@UniqueConstraint(name = "unq_cpf", columnNames = "cpf"),
    indexes = @Index(name = "idx_nome", columnList = "nome"))
public class Cliente extends EntidadeBase {

  @Column(nullable = false)
  private String nome;

  @Column(nullable = false, length = 14)
  private String cpf;

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
