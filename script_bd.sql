drop database `sis-escolar`;

CREATE SCHEMA IF NOT EXISTS `sis-escolar` DEFAULT CHARACTER SET utf8 ;
USE `sis-escolar` ;

-- -----------------------------------------------------
-- Table `sis-escolar`.`tb_roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sis-escolar`.`tb_roles` (
  `id_roles` INT(11) NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_roles`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `sis-escolar`.`tb_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sis-escolar`.`tb_usuario` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(255) NULL DEFAULT NULL,
  `senha` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `sis-escolar`.`tb_roles_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sis-escolar`.`tb_roles_usuario` (
  `id_roles` INT(11) NOT NULL,
  `id_usuario` INT(11) NOT NULL,
  PRIMARY KEY (`id_roles`, `id_usuario`),
  INDEX `fk_tb_roles_has_tb_usuario_tb_usuario1_idx` (`id_usuario` ASC),
  INDEX `fk_tb_roles_has_tb_usuario_tb_roles_idx` (`id_roles` ASC),
  CONSTRAINT `fk_tb_roles_has_tb_usuario_tb_roles`
    FOREIGN KEY (`id_roles`)
    REFERENCES `sis-escolar`.`tb_roles` (`id_roles`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_roles_has_tb_usuario_tb_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `sis-escolar`.`tb_usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `sis-escolar`.`tb_curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sis-escolar`.`tb_curso` (
  `id_curso` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NOT NULL,
  `codigo` INT(10) NOT NULL,
  PRIMARY KEY (`id_curso`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sis-escolar`.`tb_aluno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sis-escolar`.`tb_aluno` (
  `id_aluno` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `id_curso` INT NOT NULL,
  PRIMARY KEY (`id_aluno`),
  INDEX `fk_tb_aluno_tb_curso1_idx` (`id_curso` ASC),
  CONSTRAINT `fk_tb_aluno_tb_curso1`
    FOREIGN KEY (`id_curso`)
    REFERENCES `sis-escolar`.`tb_curso` (`id_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sis-escolar`.`tb_turma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sis-escolar`.`tb_turma` (
  `id_turma` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NULL,
  `codigo` INT(8) NOT NULL,
  `id_curso` INT NOT NULL,
  PRIMARY KEY (`id_turma`),
  INDEX `fk_tb_turma_tb_curso1_idx` (`id_curso` ASC),
  CONSTRAINT `fk_tb_turma_tb_curso1`
    FOREIGN KEY (`id_curso`)
    REFERENCES `sis-escolar`.`tb_curso` (`id_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sis-escolar`.`tb_disciplina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sis-escolar`.`tb_disciplina` (
  `id_disciplina` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NOT NULL,
  `creditos` INT(8) NOT NULL,
  `semestre` INT(2) NOT NULL,
  `id_curso` INT NOT NULL,
  PRIMARY KEY (`id_disciplina`),
  INDEX `fk_tb_disciplina_tb_curso1_idx` (`id_curso` ASC),
  CONSTRAINT `fk_tb_disciplina_tb_curso1`
    FOREIGN KEY (`id_curso`)
    REFERENCES `sis-escolar`.`tb_curso` (`id_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sis-escolar`.`tb_turma_aluno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sis-escolar`.`tb_turma_aluno` (
  `id_turma` INT NOT NULL,
  `id_aluno` INT NOT NULL,
  PRIMARY KEY (`id_turma`, `id_aluno`),
  INDEX `fk_tb_turma_has_tb_aluno_tb_aluno1_idx` (`id_aluno` ASC),
  INDEX `fk_tb_turma_has_tb_aluno_tb_turma1_idx` (`id_turma` ASC),
  CONSTRAINT `fk_tb_turma_has_tb_aluno_tb_turma1`
    FOREIGN KEY (`id_turma`)
    REFERENCES `sis-escolar`.`tb_turma` (`id_turma`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_turma_has_tb_aluno_tb_aluno1`
    FOREIGN KEY (`id_aluno`)
    REFERENCES `sis-escolar`.`tb_aluno` (`id_aluno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `sis-escolar`.`tb_nota` (
  `id_nota` INT(11) NOT NULL AUTO_INCREMENT,
  `nota_1` DOUBLE NULL DEFAULT NULL,
  `nota_2` DOUBLE NULL DEFAULT NULL,
  `nota_3` DOUBLE NULL DEFAULT NULL,
  `nota_4` DOUBLE NULL DEFAULT NULL,
  `nota_rec` DOUBLE NULL DEFAULT NULL,
  `nota_final` DOUBLE NULL DEFAULT NULL,
  `id_aluno` INT(11) NOT NULL,
  `id_disciplina` INT(11) NOT NULL,
  PRIMARY KEY (`id_nota`),
  INDEX `fk_tb_nota_tb_aluno1_idx` (`id_aluno` ASC),
  INDEX `fk_tb_nota_tb_disciplina1_idx` (`id_disciplina` ASC),
  CONSTRAINT `fk_tb_nota_tb_aluno1`
    FOREIGN KEY (`id_aluno`)
    REFERENCES `sis-escolar`.`tb_aluno` (`id_aluno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_nota_tb_disciplina1`
    FOREIGN KEY (`id_disciplina`)
    REFERENCES `sis-escolar`.`tb_disciplina` (`id_disciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

ALTER TABLE `sis-escolar`.`tb_aluno` 
ADD COLUMN `usuario_id` INT(11) NULL AFTER `id_curso`,
ADD INDEX `fk_tb_aluno_tb_usuario1_idx` (`usuario_id` ASC);

ALTER TABLE `sis-escolar`.`tb_aluno` 
ADD CONSTRAINT `fk_tb_aluno_tb_usuario1`
  FOREIGN KEY (`usuario_id`)
  REFERENCES `sis-escolar`.`tb_usuario` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
ALTER TABLE `sis-escolar`.`tb_disciplina` 
ADD COLUMN `id_turma` INT(11) NULL AFTER `id_curso`,
ADD INDEX `fk_tb_disciplina_tb_turma1_idx` (`id_turma` ASC);

ALTER TABLE `sis-escolar`.`tb_disciplina` 
ADD CONSTRAINT `fk_tb_disciplina_tb_turma1`
  FOREIGN KEY (`id_turma`)
  REFERENCES `sis-escolar`.`tb_turma` (`id_turma`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  ALTER TABLE `sis-escolar`.`tb_aluno` 
DROP FOREIGN KEY `fk_tb_aluno_tb_usuario1`;

ALTER TABLE `sis-escolar`.`tb_disciplina` 
DROP FOREIGN KEY `fk_tb_disciplina_tb_turma1`;

ALTER TABLE `sis-escolar`.`tb_nota` 
DROP FOREIGN KEY `fk_tb_nota_tb_aluno1`;

ALTER TABLE `sis-escolar`.`tb_disciplina` 
DROP COLUMN `id_turma`,
DROP COLUMN `semestre`,
ADD COLUMN `id_turma` INT(11) NOT NULL AFTER `id_curso`,
ADD COLUMN `id_periodo` INT(11) NOT NULL AFTER `id_turma`,
ADD COLUMN `id_frequencia` INT(11) NOT NULL AFTER `id_periodo`,
ADD INDEX `fk_tb_disciplina_tb_turma1_idx` (`id_turma` ASC),
ADD INDEX `fk_tb_disciplina_tb_periodo1_idx` (`id_periodo` ASC),
ADD INDEX `fk_tb_disciplina_tb_frequencia1_idx` (`id_frequencia` ASC),
DROP INDEX `fk_tb_disciplina_tb_turma1_idx` ;

ALTER TABLE `sis-escolar`.`tb_nota` 
DROP COLUMN `id_aluno`,
DROP INDEX `fk_tb_nota_tb_aluno1_idx` ;

CREATE TABLE IF NOT EXISTS `sis-escolar`.`tb_periodo` (
  `id_periodo` INT(11) NOT NULL AUTO_INCREMENT,
  `semestre` INT(11) NOT NULL,
  `ano` INT(4) NOT NULL,
  PRIMARY KEY (`id_periodo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE TABLE IF NOT EXISTS `sis-escolar`.`tb_frequencia` (
  `id_frequencia` INT(11) NOT NULL AUTO_INCREMENT,
  `qtde_aulas` INT(4) NOT NULL,
  `freq_1` INT(4) NULL DEFAULT NULL,
  `freq_2` INT(4) NULL DEFAULT NULL,
  `freq_3` INT(4) NULL DEFAULT NULL,
  `freq_4` INT(4) NULL DEFAULT NULL,
  `freq_5` INT(4) NULL DEFAULT NULL,
  `id_periodo` INT(11) NOT NULL,
  PRIMARY KEY (`id_frequencia`),
  INDEX `fk_tb_frequencia_tb_periodo1_idx` (`id_periodo` ASC),
  CONSTRAINT `fk_tb_frequencia_tb_periodo1`
    FOREIGN KEY (`id_periodo`)
    REFERENCES `sis-escolar`.`tb_periodo` (`id_periodo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE TABLE IF NOT EXISTS `sis-escolar`.`tb_aluno_disciplina` (
  `id_aluno` INT(11) NOT NULL,
  `id_disciplina` INT(11) NOT NULL,
  PRIMARY KEY (`id_aluno`, `id_disciplina`),
  INDEX `fk_tb_aluno_has_tb_disciplina_tb_disciplina1_idx` (`id_disciplina` ASC),
  INDEX `fk_tb_aluno_has_tb_disciplina_tb_aluno1_idx` (`id_aluno` ASC),
  CONSTRAINT `fk_tb_aluno_has_tb_disciplina_tb_aluno1`
    FOREIGN KEY (`id_aluno`)
    REFERENCES `sis-escolar`.`tb_aluno` (`id_aluno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_aluno_has_tb_disciplina_tb_disciplina1`
    FOREIGN KEY (`id_disciplina`)
    REFERENCES `sis-escolar`.`tb_disciplina` (`id_disciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

ALTER TABLE `sis-escolar`.`tb_aluno` 
ADD CONSTRAINT `fk_tb_aluno_tb_usuario1`
  FOREIGN KEY (`usuario_id`)
  REFERENCES `sis-escolar`.`tb_usuario` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `sis-escolar`.`tb_disciplina` 
ADD CONSTRAINT `fk_tb_disciplina_tb_turma1`
  FOREIGN KEY (`id_turma`)
  REFERENCES `sis-escolar`.`tb_turma` (`id_turma`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_tb_disciplina_tb_periodo1`
  FOREIGN KEY (`id_periodo`)
  REFERENCES `sis-escolar`.`tb_periodo` (`id_periodo`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_tb_disciplina_tb_frequencia1`
  FOREIGN KEY (`id_frequencia`)
  REFERENCES `sis-escolar`.`tb_frequencia` (`id_frequencia`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  ALTER TABLE `sis-escolar`.`tb_nota` 
ADD COLUMN `id_aluno` INT(11) NOT NULL AFTER `id_disciplina`,
ADD INDEX `fk_tb_nota_tb_aluno1_idx` (`id_aluno` ASC);

ALTER TABLE `sis-escolar`.`tb_nota` 
ADD CONSTRAINT `fk_tb_nota_tb_aluno1`
  FOREIGN KEY (`id_aluno`)
  REFERENCES `sis-escolar`.`tb_aluno` (`id_aluno`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
ALTER TABLE `sis-escolar`.`tb_aluno` 
DROP FOREIGN KEY `fk_tb_aluno_tb_usuario1`;

ALTER TABLE `sis-escolar`.`tb_nota` 
DROP FOREIGN KEY `fk_tb_nota_tb_aluno1`;

ALTER TABLE `sis-escolar`.`tb_aluno` 
CHANGE COLUMN `usuario_id` `usuario_id` INT(11) NULL ;

CREATE TABLE IF NOT EXISTS `sis-escolar`.`tb_extrato` (
  `id_extrato` INT(11) NOT NULL AUTO_INCREMENT,
  `vencimento` DATE NOT NULL,
  `valor` DOUBLE NOT NULL,
  `juros` DOUBLE NULL DEFAULT NULL,
  `desconto` DOUBLE NULL DEFAULT NULL,
  `multa` DOUBLE NULL DEFAULT NULL,
  `status` INT(11) NOT NULL,
  `id_periodo` INT(11) NOT NULL,
  `id_aluno` INT(11) NOT NULL,
  PRIMARY KEY (`id_extrato`, `id_aluno`),
  INDEX `fk_tb_extrato_tb_periodo1_idx` (`id_periodo` ASC),
  INDEX `fk_tb_extrato_tb_aluno1_idx` (`id_aluno` ASC),
  CONSTRAINT `fk_tb_extrato_tb_periodo1`
    FOREIGN KEY (`id_periodo`)
    REFERENCES `sis-escolar`.`tb_periodo` (`id_periodo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_extrato_tb_aluno1`
    FOREIGN KEY (`id_aluno`)
    REFERENCES `sis-escolar`.`tb_aluno` (`id_aluno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

ALTER TABLE `sis-escolar`.`tb_aluno` 
ADD CONSTRAINT `fk_tb_aluno_tb_usuario1`
  FOREIGN KEY (`usuario_id`)
  REFERENCES `sis-escolar`.`tb_usuario` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE tb_usuario AUTO_INCREMENT = 1;
ALTER TABLE tb_roles AUTO_INCREMENT = 1;
ALTER TABLE tb_roles_usuario AUTO_INCREMENT = 1;
ALTER TABLE tb_curso AUTO_INCREMENT = 1;
ALTER TABLE tb_disciplina AUTO_INCREMENT = 1;
ALTER TABLE tb_aluno AUTO_INCREMENT = 1;
ALTER TABLE tb_turma AUTO_INCREMENT = 1;
ALTER TABLE tb_turma_aluno AUTO_INCREMENT = 1;
ALTER TABLE tb_nota AUTO_INCREMENT = 1;
ALTER TABLE tb_aluno_disciplina AUTO_INCREMENT = 1;
ALTER TABLE tb_frequencia AUTO_INCREMENT = 1;
ALTER TABLE tb_periodo AUTO_INCREMENT = 1;

INSERT INTO `sis-escolar`.`tb_roles` (`descricao`) VALUES ('admin');
INSERT INTO `sis-escolar`.`tb_roles` (`descricao`) VALUES ('professor');
INSERT INTO `sis-escolar`.`tb_roles` (`descricao`) VALUES ('aluno');

INSERT INTO `sis-escolar`.`tb_usuario` (`login`, `senha`) VALUES ('admin', 'd41d8cd98f00b204e9800998ecf8427e');
INSERT INTO `sis-escolar`.`tb_usuario` (`login`, `senha`) VALUES ('aluno', 'd41d8cd98f00b204e9800998ecf8427e');

INSERT INTO `sis-escolar`.`tb_roles_usuario` (`id_roles`, `id_usuario`) VALUES ('1', '1');
INSERT INTO `sis-escolar`.`tb_roles_usuario` (`id_roles`, `id_usuario`) VALUES ('3', '2');

INSERT INTO `sis-escolar`.`tb_curso` (`descricao`, `codigo`) VALUES ('Ciência da Computação', '002');
INSERT INTO `sis-escolar`.`tb_curso` (`descricao`, `codigo`) VALUES ('Psicologia', '003');
INSERT INTO `sis-escolar`.`tb_curso` (`descricao`, `codigo`) VALUES ('Geografia', '004');
INSERT INTO `sis-escolar`.`tb_curso` (`descricao`, `codigo`) VALUES ('Matemática', '005');
INSERT INTO `sis-escolar`.`tb_curso` (`descricao`, `codigo`) VALUES ('Física', '006');
INSERT INTO `sis-escolar`.`tb_curso` (`descricao`, `codigo`) VALUES ('Medicina', '007');
INSERT INTO `sis-escolar`.`tb_curso` (`descricao`, `codigo`) VALUES ('Direito', '008');
INSERT INTO `sis-escolar`.`tb_curso` (`descricao`, `codigo`) VALUES ('Enfermagem', '009');
INSERT INTO `sis-escolar`.`tb_curso` (`descricao`, `codigo`) VALUES ('Jornalismo', '010');

INSERT INTO `sis-escolar`.`tb_periodo` (`semestre`, `ano`) VALUES ('1', '2014');
INSERT INTO `sis-escolar`.`tb_periodo` (`semestre`, `ano`) VALUES ('2', '2014');
INSERT INTO `sis-escolar`.`tb_periodo` (`semestre`, `ano`) VALUES ('1', '2015');
INSERT INTO `sis-escolar`.`tb_periodo` (`semestre`, `ano`) VALUES ('2', '2015');

INSERT INTO `sis-escolar`.`tb_frequencia` (`qtde_aulas`, `freq_1`, `freq_2`, `freq_3`, `freq_4`, `freq_5`, `id_periodo`) VALUES ('15', '10', '8', '9', '7', '6', '1');
INSERT INTO `sis-escolar`.`tb_frequencia` (`qtde_aulas`, `freq_1`, `freq_2`, `freq_3`, `freq_4`, `freq_5`, `id_periodo`) VALUES ('17', '10', '10', '5', '8', '9', '2');
INSERT INTO `sis-escolar`.`tb_frequencia` (`qtde_aulas`, `freq_1`, `freq_2`, `freq_3`, `freq_4`, `freq_5`, `id_periodo`) VALUES ('14', '10', '10', '10', '10', '10', '3');
INSERT INTO `sis-escolar`.`tb_frequencia` (`qtde_aulas`, `freq_1`, `freq_2`, `freq_3`, `freq_4`, `freq_5`, `id_periodo`) VALUES ('20', '4', '4', '4', '4', '5', '4');

INSERT INTO `sis-escolar`.`tb_turma` (`descricao`, `codigo`, `id_curso`) VALUES ('CC001', '001', '1');
INSERT INTO `sis-escolar`.`tb_turma` (`descricao`, `codigo`, `id_curso`) VALUES ('CC002', '002', '1');
INSERT INTO `sis-escolar`.`tb_turma` (`descricao`, `codigo`, `id_curso`) VALUES ('CC003', '003', '1');
INSERT INTO `sis-escolar`.`tb_turma` (`descricao`, `codigo`, `id_curso`) VALUES ('PS001', '004', '2');
INSERT INTO `sis-escolar`.`tb_turma` (`descricao`, `codigo`, `id_curso`) VALUES ('PS002', '005', '2');
INSERT INTO `sis-escolar`.`tb_turma` (`descricao`, `codigo`, `id_curso`) VALUES ('PS003', '006', '2');
INSERT INTO `sis-escolar`.`tb_turma` (`descricao`, `codigo`, `id_curso`) VALUES ('GE001', '007', '3');
INSERT INTO `sis-escolar`.`tb_turma` (`descricao`, `codigo`, `id_curso`) VALUES ('GE002', '008', '3');
INSERT INTO `sis-escolar`.`tb_turma` (`descricao`, `codigo`, `id_curso`) VALUES ('MT001', '009', '4');
INSERT INTO `sis-escolar`.`tb_turma` (`descricao`, `codigo`, `id_curso`) VALUES ('MT002', '010', '5');
INSERT INTO `sis-escolar`.`tb_turma` (`descricao`, `codigo`, `id_curso`) VALUES ('FS001', '011', '6');
INSERT INTO `sis-escolar`.`tb_turma` (`descricao`, `codigo`, `id_curso`) VALUES ('FS002', '012', '7');
INSERT INTO `sis-escolar`.`tb_turma` (`descricao`, `codigo`, `id_curso`) VALUES ('MD001', '013', '8');
INSERT INTO `sis-escolar`.`tb_turma` (`descricao`, `codigo`, `id_curso`) VALUES ('MD002', '014', '8');
INSERT INTO `sis-escolar`.`tb_turma` (`descricao`, `codigo`, `id_curso`) VALUES ('DI001', '015', '9');
INSERT INTO `sis-escolar`.`tb_turma` (`descricao`, `codigo`, `id_curso`) VALUES ('DI002', '016', '9');

INSERT INTO `sis-escolar`.`tb_disciplina` (`descricao`, `creditos`, `id_curso`, `id_turma`, `id_periodo`, `id_frequencia`) VALUES ('Introdução à Computação', '40', '1', '1', '1', '1');
INSERT INTO `sis-escolar`.`tb_disciplina` (`descricao`, `creditos`, `id_curso`, `id_turma`, `id_periodo`, `id_frequencia`) VALUES ('Lógica de Programação', '40', '1', '1', '2', '1');
INSERT INTO `sis-escolar`.`tb_disciplina` (`descricao`, `creditos`, `id_curso`, `id_turma`, `id_periodo`, `id_frequencia`) VALUES ('Compiladores', '80', '1', '1', '3', '1');
INSERT INTO `sis-escolar`.`tb_disciplina` (`descricao`, `creditos`, `id_curso`, `id_turma`, `id_periodo`, `id_frequencia`) VALUES ('Arquitetura de Computadores', '80', '1', '1', '4', '1');
INSERT INTO `sis-escolar`.`tb_disciplina` (`descricao`, `creditos`, `id_curso`, `id_turma`, `id_periodo`, `id_frequencia`) VALUES ('Introdução à Psicologia', '40', '2', '1', '1', '1');
INSERT INTO `sis-escolar`.`tb_disciplina` (`descricao`, `creditos`, `id_curso`, `id_turma`, `id_periodo`, `id_frequencia`) VALUES ('Psicologia do Trabalho', '80', '2', '1', '1', '1');
INSERT INTO `sis-escolar`.`tb_disciplina` (`descricao`, `creditos`, `id_curso`, `id_turma`, `id_periodo`, `id_frequencia`) VALUES ('Geografia do Brasil', '80', '3', '1', '1', '1');
INSERT INTO `sis-escolar`.`tb_disciplina` (`descricao`, `creditos`, `id_curso`, `id_turma`, `id_periodo`, `id_frequencia`) VALUES ('Rochas e Solos', '40', '3', '1', '1', '1');
INSERT INTO `sis-escolar`.`tb_disciplina` (`descricao`, `creditos`, `id_curso`, `id_turma`, `id_periodo`, `id_frequencia`) VALUES ('Matemática Discreta', '40', '4', '1', '1', '1');
INSERT INTO `sis-escolar`.`tb_disciplina` (`descricao`, `creditos`, `id_curso`, `id_turma`, `id_periodo`, `id_frequencia`) VALUES ('Álgebra Linear', '80', '4', '1', '1', '1');
INSERT INTO `sis-escolar`.`tb_disciplina` (`descricao`, `creditos`, `id_curso`, `id_turma`, `id_periodo`, `id_frequencia`) VALUES ('Introdução à Física', '40', '5', '1', '1', '1');
INSERT INTO `sis-escolar`.`tb_disciplina` (`descricao`, `creditos`, `id_curso`, `id_turma`, `id_periodo`, `id_frequencia`) VALUES ('Física Quântica', '80', '5', '1', '1', '1');
INSERT INTO `sis-escolar`.`tb_disciplina` (`descricao`, `creditos`, `id_curso`, `id_turma`, `id_periodo`, `id_frequencia`) VALUES ('Biologia do Corpo Humano', '40', '6', '1', '1', '1');
INSERT INTO `sis-escolar`.`tb_disciplina` (`descricao`, `creditos`, `id_curso`, `id_turma`, `id_periodo`, `id_frequencia`) VALUES ('Anatomia Humana', '80', '6', '1', '1', '1');
INSERT INTO `sis-escolar`.`tb_disciplina` (`descricao`, `creditos`, `id_curso`, `id_turma`, `id_periodo`, `id_frequencia`) VALUES ('Leis Brasileiras', '40', '7', '1', '1', '1');
INSERT INTO `sis-escolar`.`tb_disciplina` (`descricao`, `creditos`, `id_curso`, `id_turma`, `id_periodo`, `id_frequencia`) VALUES ('Direito Civil Aplicado', '80', '7', '1', '1', '1');
INSERT INTO `sis-escolar`.`tb_disciplina` (`descricao`, `creditos`, `id_curso`, `id_turma`, `id_periodo`, `id_frequencia`) VALUES ('Introdução à Enfermagem', '40', '8', '1', '1', '1');
INSERT INTO `sis-escolar`.`tb_disciplina` (`descricao`, `creditos`, `id_curso`, `id_turma`, `id_periodo`, `id_frequencia`) VALUES ('Técnicas Avançadas', '80', '8', '1', '1', '1');

INSERT INTO `sis-escolar`.`tb_aluno` (`nome`, `id_curso`) VALUES ('Diogo Souza ', '1');
INSERT INTO `sis-escolar`.`tb_aluno` (`nome`, `id_curso`) VALUES ('Bruna Karla', '1');
INSERT INTO `sis-escolar`.`tb_aluno` (`nome`, `id_curso`) VALUES ('Samuel Sousa', '1');
INSERT INTO `sis-escolar`.`tb_aluno` (`nome`, `id_curso`) VALUES ('João Rosa', '1');
INSERT INTO `sis-escolar`.`tb_aluno` (`nome`, `id_curso`) VALUES ('Maria Luana', '2');
INSERT INTO `sis-escolar`.`tb_aluno` (`nome`, `id_curso`) VALUES ('Sebastião Cleiton', '2');
INSERT INTO `sis-escolar`.`tb_aluno` (`nome`, `id_curso`) VALUES ('Pedro Manoel', '3');
INSERT INTO `sis-escolar`.`tb_aluno` (`nome`, `id_curso`) VALUES ('Ricardo Barbosa', '3');
INSERT INTO `sis-escolar`.`tb_aluno` (`nome`, `id_curso`) VALUES ('Henrique Mourão', '4');
INSERT INTO `sis-escolar`.`tb_aluno` (`nome`, `id_curso`) VALUES ('Fabrício Castro', '4');
INSERT INTO `sis-escolar`.`tb_aluno` (`nome`, `id_curso`) VALUES ('Luana de Oliveira', '5');
INSERT INTO `sis-escolar`.`tb_aluno` (`nome`, `id_curso`) VALUES ('Bruno Fidel', '5');
INSERT INTO `sis-escolar`.`tb_aluno` (`nome`, `id_curso`) VALUES ('Rafael Pereira', '6');
INSERT INTO `sis-escolar`.`tb_aluno` (`nome`, `id_curso`) VALUES ('Rafaela Martins', '6');
INSERT INTO `sis-escolar`.`tb_aluno` (`nome`, `id_curso`) VALUES ('Junio Sampaio', '7');
INSERT INTO `sis-escolar`.`tb_aluno` (`nome`, `id_curso`) VALUES ('Manuel Cardoso', '7');
INSERT INTO `sis-escolar`.`tb_aluno` (`nome`, `id_curso`) VALUES ('Felipe Ribeiro', '8');
INSERT INTO `sis-escolar`.`tb_aluno` (`nome`, `id_curso`) VALUES ('Ana Coutinho', '8');

INSERT INTO `sis-escolar`.`tb_aluno_disciplina` (`id_aluno`, `id_disciplina`) VALUES ('1', '1');
INSERT INTO `sis-escolar`.`tb_aluno_disciplina` (`id_aluno`, `id_disciplina`) VALUES ('1', '2');
INSERT INTO `sis-escolar`.`tb_aluno_disciplina` (`id_aluno`, `id_disciplina`) VALUES ('1', '3');
INSERT INTO `sis-escolar`.`tb_aluno_disciplina` (`id_aluno`, `id_disciplina`) VALUES ('1', '4');
INSERT INTO `sis-escolar`.`tb_aluno_disciplina` (`id_aluno`, `id_disciplina`) VALUES ('2', '1');
INSERT INTO `sis-escolar`.`tb_aluno_disciplina` (`id_aluno`, `id_disciplina`) VALUES ('2', '2');
INSERT INTO `sis-escolar`.`tb_aluno_disciplina` (`id_aluno`, `id_disciplina`) VALUES ('2', '3');

INSERT INTO `sis-escolar`.`tb_turma_aluno` (`id_turma`, `id_aluno`) VALUES ('1', '1');
INSERT INTO `sis-escolar`.`tb_turma_aluno` (`id_turma`, `id_aluno`) VALUES ('2', '1');
INSERT INTO `sis-escolar`.`tb_turma_aluno` (`id_turma`, `id_aluno`) VALUES ('1', '2');
INSERT INTO `sis-escolar`.`tb_turma_aluno` (`id_turma`, `id_aluno`) VALUES ('3', '3');
INSERT INTO `sis-escolar`.`tb_turma_aluno` (`id_turma`, `id_aluno`) VALUES ('1', '4');
INSERT INTO `sis-escolar`.`tb_turma_aluno` (`id_turma`, `id_aluno`) VALUES ('2', '4');
INSERT INTO `sis-escolar`.`tb_turma_aluno` (`id_turma`, `id_aluno`) VALUES ('4', '5');
INSERT INTO `sis-escolar`.`tb_turma_aluno` (`id_turma`, `id_aluno`) VALUES ('5', '5');
INSERT INTO `sis-escolar`.`tb_turma_aluno` (`id_turma`, `id_aluno`) VALUES ('6', '5');
INSERT INTO `sis-escolar`.`tb_turma_aluno` (`id_turma`, `id_aluno`) VALUES ('5', '6');
INSERT INTO `sis-escolar`.`tb_turma_aluno` (`id_turma`, `id_aluno`) VALUES ('6', '6');
INSERT INTO `sis-escolar`.`tb_turma_aluno` (`id_turma`, `id_aluno`) VALUES ('7', '7');
INSERT INTO `sis-escolar`.`tb_turma_aluno` (`id_turma`, `id_aluno`) VALUES ('8', '7');
INSERT INTO `sis-escolar`.`tb_turma_aluno` (`id_turma`, `id_aluno`) VALUES ('7', '8');
INSERT INTO `sis-escolar`.`tb_turma_aluno` (`id_turma`, `id_aluno`) VALUES ('9', '9');
INSERT INTO `sis-escolar`.`tb_turma_aluno` (`id_turma`, `id_aluno`) VALUES ('9', '10');
INSERT INTO `sis-escolar`.`tb_turma_aluno` (`id_turma`, `id_aluno`) VALUES ('10', '11');
INSERT INTO `sis-escolar`.`tb_turma_aluno` (`id_turma`, `id_aluno`) VALUES ('10', '12');
INSERT INTO `sis-escolar`.`tb_turma_aluno` (`id_turma`, `id_aluno`) VALUES ('11', '13');
INSERT INTO `sis-escolar`.`tb_turma_aluno` (`id_turma`, `id_aluno`) VALUES ('11', '14');
INSERT INTO `sis-escolar`.`tb_turma_aluno` (`id_turma`, `id_aluno`) VALUES ('12', '15');
INSERT INTO `sis-escolar`.`tb_turma_aluno` (`id_turma`, `id_aluno`) VALUES ('12', '16');
INSERT INTO `sis-escolar`.`tb_turma_aluno` (`id_turma`, `id_aluno`) VALUES ('13', '17');
INSERT INTO `sis-escolar`.`tb_turma_aluno` (`id_turma`, `id_aluno`) VALUES ('13', '18');
INSERT INTO `sis-escolar`.`tb_turma_aluno` (`id_turma`, `id_aluno`) VALUES ('14', '17');

INSERT INTO `sis-escolar`.`tb_nota` (`nota_1`, `nota_2`, `nota_3`, `nota_4`, `id_disciplina`, `id_aluno`) VALUES ('7', '8', '5', '5.6', '1', '1');
INSERT INTO `sis-escolar`.`tb_nota` (`nota_1`, `nota_2`, `nota_3`, `nota_4`, `id_disciplina`, `id_aluno`) VALUES ('4', '4', '3', '2', '2', '1');
INSERT INTO `sis-escolar`.`tb_nota` (`nota_1`, `nota_2`, `nota_3`, `nota_4`, `id_disciplina`, `id_aluno`) VALUES ('7', '8', '5', '5.6', '3', '2');
INSERT INTO `sis-escolar`.`tb_nota` (`nota_1`, `nota_2`, `nota_3`, `nota_4`, `id_disciplina`, `id_aluno`) VALUES ('4', '4', '3', '2', '4', '2');

UPDATE `sis-escolar`.`tb_aluno` SET `usuario_id`='2' WHERE `id_aluno`='1';

UPDATE `sis-escolar`.`tb_disciplina` SET `id_turma`='1' WHERE `id_disciplina`='1';
UPDATE `sis-escolar`.`tb_disciplina` SET `id_turma`='1' WHERE `id_disciplina`='2';
UPDATE `sis-escolar`.`tb_disciplina` SET `id_turma`='2' WHERE `id_disciplina`='3';
UPDATE `sis-escolar`.`tb_disciplina` SET `id_turma`='3' WHERE `id_disciplina`='4';

INSERT INTO `sis-escolar`.`tb_extrato` (`vencimento`, `valor`, `juros`, `desconto`, `multa`, `status`, `id_periodo`, `id_aluno`) VALUES ('2015-01-01', '450', '45', '450', '12', '1', '1', '1');
INSERT INTO `sis-escolar`.`tb_extrato` (`vencimento`, `valor`, `desconto`, `status`, `id_periodo`, `id_aluno`) VALUES ('2015-01-01', '450', '450', '1', '1', '2');
INSERT INTO `sis-escolar`.`tb_extrato` (`vencimento`, `valor`, `juros`, `desconto`, `status`, `id_periodo`, `id_aluno`) VALUES ('2015-01-01', '450', '12', '450', '1', '2', '1');
INSERT INTO `sis-escolar`.`tb_extrato` (`vencimento`, `valor`, `desconto`, `status`, `id_periodo`, `id_aluno`) VALUES ('2015-01-01', '450', '450', '2', '2', '2');
