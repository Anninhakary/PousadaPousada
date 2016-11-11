SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

DROP SCHEMA IF EXISTS `chaleDB` ;
CREATE SCHEMA IF NOT EXISTS `chaleDB` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `chaleDB` ;

-- -----------------------------------------------------
-- Table `chaleDB`.`equipamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chaleDB`.`equipamento` ;

CREATE  TABLE IF NOT EXISTS `chaleDB`.`equipamento` (
  `idequipamento` INT NOT NULL AUTO_INCREMENT ,
  `descrição` VARCHAR(45) NULL ,
  PRIMARY KEY (`idequipamento`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chaleDB`.`pessoaCliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chaleDB`.`pessoaCliente` ;

CREATE  TABLE IF NOT EXISTS `chaleDB`.`pessoaCliente` (
  `idcliente` INT NOT NULL ,
  `referencia` VARCHAR(45) NOT NULL ,
  `rua` VARCHAR(45) NOT NULL ,
  `cep` VARCHAR(45) NOT NULL ,
  `estado` VARCHAR(45) NOT NULL ,
  `cidade` VARCHAR(45) NOT NULL ,
  `pais` VARCHAR(45) NOT NULL ,
  `clientecol` VARCHAR(45) NOT NULL ,
  `nome` VARCHAR(45) NOT NULL ,
  `dataNascimento` DATE NOT NULL ,
  `login` VARCHAR(45) NOT NULL ,
  `senha` VARCHAR(45) NOT NULL ,
  `privilegio` INT NOT NULL ,
  PRIMARY KEY (`idcliente`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chaleDB`.`chale`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chaleDB`.`chale` ;

CREATE  TABLE IF NOT EXISTS `chaleDB`.`chale` (
  `numero` INT NOT NULL AUTO_INCREMENT ,
  `diaria` FLOAT NULL ,
  `estaOcupado` TINYINT(1) NOT NULL ,
  PRIMARY KEY (`numero`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chaleDB`.`reserva`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chaleDB`.`reserva` ;

CREATE  TABLE IF NOT EXISTS `chaleDB`.`reserva` (
  `idreserva` INT NOT NULL AUTO_INCREMENT ,
  `dataInicio` DATE NULL ,
  `dataFim` DATE NULL ,
  `pessoaCliente_idcliente` INT NOT NULL ,
  `chale_numero` INT NOT NULL ,
  PRIMARY KEY (`idreserva`) ,
  INDEX `fk_reserva_pessoaCliente1` (`pessoaCliente_idcliente` ASC) ,
  INDEX `fk_reserva_chale1` (`chale_numero` ASC) ,
  CONSTRAINT `fk_reserva_pessoaCliente1`
    FOREIGN KEY (`pessoaCliente_idcliente` )
    REFERENCES `chaleDB`.`pessoaCliente` (`idcliente` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reserva_chale1`
    FOREIGN KEY (`chale_numero` )
    REFERENCES `chaleDB`.`chale` (`numero` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chaleDB`.`hospedagem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chaleDB`.`hospedagem` ;

CREATE  TABLE IF NOT EXISTS `chaleDB`.`hospedagem` (
  `idhospedagem` INT NOT NULL AUTO_INCREMENT ,
  `qntAcomp` VARCHAR(45) NULL ,
  `dataInicio` DATE NULL ,
  `previsão` INT NULL ,
  `dataSaida` DATE NULL ,
  `chale_numero` INT NULL ,
  `valor` FLOAT NOT NULL ,
  PRIMARY KEY (`idhospedagem`) ,
  INDEX `fk_hospedagem_chale1` (`chale_numero` ASC) ,
  CONSTRAINT `fk_hospedagem_chale1`
    FOREIGN KEY (`chale_numero` )
    REFERENCES `chaleDB`.`chale` (`numero` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chaleDB`.`pessoaAdmProprietario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chaleDB`.`pessoaAdmProprietario` ;

CREATE  TABLE IF NOT EXISTS `chaleDB`.`pessoaAdmProprietario` (
  `idpessoaAdministrador` INT NOT NULL ,
  `nome` VARCHAR(45) NOT NULL ,
  `senha` VARCHAR(45) NOT NULL ,
  `login` VARCHAR(45) NOT NULL ,
  `privilegio` VARCHAR(45) NOT NULL ,
  `dataNascimento` DATE NOT NULL ,
  PRIMARY KEY (`idpessoaAdministrador`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chaleDB`.`telefone`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chaleDB`.`telefone` ;

CREATE  TABLE IF NOT EXISTS `chaleDB`.`telefone` (
  `numero` VARCHAR(15) NOT NULL ,
  `pessoaCliente_idcliente` INT NOT NULL ,
  PRIMARY KEY (`numero`) ,
  INDEX `fk_telefone_pessoaCliente1` (`pessoaCliente_idcliente` ASC) ,
  CONSTRAINT `fk_telefone_pessoaCliente1`
    FOREIGN KEY (`pessoaCliente_idcliente` )
    REFERENCES `chaleDB`.`pessoaCliente` (`idcliente` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chaleDB`.`tipoPagamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chaleDB`.`tipoPagamento` ;

CREATE  TABLE IF NOT EXISTS `chaleDB`.`tipoPagamento` (
  `idtipoPagamento` INT NOT NULL ,
  `descrição` VARCHAR(45) NULL ,
  `hospedagem_idhospedagem` INT NOT NULL ,
  PRIMARY KEY (`idtipoPagamento`, `hospedagem_idhospedagem`) ,
  INDEX `fk_tipoPagamento_hospedagem1` (`hospedagem_idhospedagem` ASC) ,
  CONSTRAINT `fk_tipoPagamento_hospedagem1`
    FOREIGN KEY (`hospedagem_idhospedagem` )
    REFERENCES `chaleDB`.`hospedagem` (`idhospedagem` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chaleDB`.`serviço`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chaleDB`.`serviço` ;

CREATE  TABLE IF NOT EXISTS `chaleDB`.`serviço` (
  `idserviço` INT NOT NULL ,
  `nome` VARCHAR(45) NOT NULL ,
  `descrição` VARCHAR(45) NULL ,
  PRIMARY KEY (`idserviço`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chaleDB`.`reciboDeServiço`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chaleDB`.`reciboDeServiço` ;

CREATE  TABLE IF NOT EXISTS `chaleDB`.`reciboDeServiço` (
  `idreciboDeServiço` INT NOT NULL ,
  `data` VARCHAR(45) NOT NULL ,
  `hora` VARCHAR(45) NOT NULL ,
  `valorTotal` VARCHAR(45) NOT NULL ,
  `serviço_idserviço` INT NOT NULL ,
  `hospedagem_idhospedagem` INT NOT NULL ,
  PRIMARY KEY (`idreciboDeServiço`) ,
  INDEX `fk_reciboDeServiço_serviço1` (`serviço_idserviço` ASC) ,
  INDEX `fk_reciboDeServiço_hospedagem1` (`hospedagem_idhospedagem` ASC) ,
  CONSTRAINT `fk_reciboDeServiço_serviço1`
    FOREIGN KEY (`serviço_idserviço` )
    REFERENCES `chaleDB`.`serviço` (`idserviço` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reciboDeServiço_hospedagem1`
    FOREIGN KEY (`hospedagem_idhospedagem` )
    REFERENCES `chaleDB`.`hospedagem` (`idhospedagem` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chaleDB`.`equipamento_has_chale`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chaleDB`.`equipamento_has_chale` ;

CREATE  TABLE IF NOT EXISTS `chaleDB`.`equipamento_has_chale` (
  `equipamento_idequipamento` INT NOT NULL ,
  `chale_numero` INT NOT NULL ,
  PRIMARY KEY (`equipamento_idequipamento`, `chale_numero`) ,
  INDEX `fk_equipamento_has_chale_chale1` (`chale_numero` ASC) ,
  INDEX `fk_equipamento_has_chale_equipamento` (`equipamento_idequipamento` ASC) ,
  CONSTRAINT `fk_equipamento_has_chale_equipamento`
    FOREIGN KEY (`equipamento_idequipamento` )
    REFERENCES `chaleDB`.`equipamento` (`idequipamento` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_equipamento_has_chale_chale1`
    FOREIGN KEY (`chale_numero` )
    REFERENCES `chaleDB`.`chale` (`numero` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chaleDB`.`pessoaAdmProprietario_has_hospedagem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chaleDB`.`pessoaAdmProprietario_has_hospedagem` ;

CREATE  TABLE IF NOT EXISTS `chaleDB`.`pessoaAdmProprietario_has_hospedagem` (
  `pessoaAdmProprietario_idpessoaAdministrador` INT NOT NULL ,
  `hospedagem_idhospedagem` INT NOT NULL ,
  PRIMARY KEY (`pessoaAdmProprietario_idpessoaAdministrador`, `hospedagem_idhospedagem`) ,
  INDEX `fk_pessoaAdmProprietario_has_hospedagem_hospedagem1` (`hospedagem_idhospedagem` ASC) ,
  INDEX `fk_pessoaAdmProprietario_has_hospedagem_pessoaAdmProprietario1` (`pessoaAdmProprietario_idpessoaAdministrador` ASC) ,
  CONSTRAINT `fk_pessoaAdmProprietario_has_hospedagem_pessoaAdmProprietario1`
    FOREIGN KEY (`pessoaAdmProprietario_idpessoaAdministrador` )
    REFERENCES `chaleDB`.`pessoaAdmProprietario` (`idpessoaAdministrador` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pessoaAdmProprietario_has_hospedagem_hospedagem1`
    FOREIGN KEY (`hospedagem_idhospedagem` )
    REFERENCES `chaleDB`.`hospedagem` (`idhospedagem` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
