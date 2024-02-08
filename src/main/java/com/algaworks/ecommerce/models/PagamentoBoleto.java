package com.algaworks.ecommerce.models;

import jakarta.persistence.Column;
import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@DiscriminatorValue("boleto")
@Entity
public class PagamentoBoleto extends Pagamento {

  @Column(name = "codigo_barras")
  private String codigoBarras;
}
