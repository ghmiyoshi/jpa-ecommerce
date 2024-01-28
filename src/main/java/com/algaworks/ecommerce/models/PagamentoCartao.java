package com.algaworks.ecommerce.models;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity(name = "pagamento_cartoes")
public class PagamentoCartao extends Pagamento {

  @Column(name = "nome_titular")
  private String nomeTitular;

  @Column(name = "numero_cartao")
  private String numeroCartao;
}
