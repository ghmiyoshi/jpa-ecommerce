package com.algaworks.ecommerce.models;

import jakarta.persistence.Column;
import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@DiscriminatorValue("cartao")
@Entity
public class PagamentoCartao extends Pagamento {

  @Column(name = "nome_titular", nullable = false)
  private String nomeTitular;

  @Column(name = "numero_cartao", length = 50)
  private String numeroCartao;
}
