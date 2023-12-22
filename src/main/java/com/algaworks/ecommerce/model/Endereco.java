package com.algaworks.ecommerce.model;

import jakarta.persistence.Embeddable;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Embeddable
public class Endereco {

  private String numero;
  private String cep;
  private String bairro;
  private String cidade;
  private String estado;
  private String logradouro;
  private String complemento;
}
