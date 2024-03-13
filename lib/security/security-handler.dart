import 'package:flutter/material.dart';

mixin SecurityHandler<T extends StatefulWidget> on State<T> {
  //late UsuarioModel? usuario;
  @override
  void initState() {
    super.initState();

    //usuario = Provider.of<AuthProvider>(context, listen: false).usuarioModel;
  }

  bool hasClaim(ClaimEnum claim) {
    //return usuario!.hasClaim(claim);
    return false;
  }
}

/*enum ClaimEnum {
  mobile_atendimento('A92', 'MOBILE_ATENDIMENTO'),
  tab_detalhe('B38', 'TAB_DETALHE'),
  tab_detalhe_visualizar('C28', 'TAB_DETALHE_VISUALIZAR'),
  tab_detalhe_executar('C29', 'TAB_DETALHE_EXECUTAR'),
  tab_sinais_vitais('B39', 'TAB_SINAIS_VITAIS'),
  tab_sinais_vitais_visualizar('C30', 'TAB_SINAIS_VITAIS_VISUALIZAR'),
  tab_sinais_vitais_executar('C31', 'TAB_SINAIS_VITAIS_EXECUTAR'),
  tab_obito('B40', 'TAB_OBITO'),
  tab_obito_visualizar('C32', 'TAB_OBITO_VISUALIZAR'),
  tab_obito_executar('C33', 'TAB_OBITO_EXECUTAR'),
  tab_prontuario('B50', 'TAB_PRONTUARIO'),
  tab_prontuario_visualizar('C34', 'TAB_PRONTUARIO_VISUALIZAR'),
  tab_prontuario_executar('C35', 'TAB_PRONTUARIO_EXECUTAR'),
  concluir_atendimento('B41', 'MOBILE_ATENDIMENTO_CONCLUIR'),
  aceitar_atendimento('B42', 'MOBILE_ATENDIMENTO_ACEITAR'),
  recusar_atendimento('B43', 'MOBILE_ATENDIMENTO_RECUSAR'),
  atualizar_equipe_veiculo('B48', 'MOBILE_ATENDIMENTO_ATUALIZAR_EQUIPE_VEICULO');

  const ClaimEnum(this.code, this.name);
  final String code;
  final String name;

  @override
  String toString() => 'ClaimEnum($code, $name)';
}*/

enum ClaimEnum {
  mobile_atendimento('A2', 'MOBILE_ATENDIMENTO'),
  tab_detalhe('B27', 'TAB_DETALHE'),
  tab_detalhe__concluir('C21', 'TAB_DETALHE__CONCLUIR'),
  tab_detalhe__confirmar_steps('C22', 'TAB_DETALHE__CONFIRMAR_STEPS'),
  tab_detalhe__visualizar('C23', 'TAB_DETALHE__VISUALIZAR'),
  tab_obito('B28', 'TAB_OBITO'),
  tab_obito__atualizar('C24', 'TAB_OBITO__ATUALIZAR'),
  tab_obito__visualizar('C25', 'TAB_OBITO__VISUALIZAR'),
  tab_prontuario('B29', 'TAB_PRONTUARIO'),
  tab_prontuario__inserir('C26', 'TAB_PRONTUARIO__INSERIR'),
  tab_prontuario__visualizar('C27', 'TAB_PRONTUARIO__VISUALIZAR'),
  tab_sinais_vitais('B30', 'TAB_SINAIS_VITAIS'),
  tab_sinais_vitais__inserir('C28', 'TAB_SINAIS_VITAIS__INSERIR'),
  tab_sinais_vitais__visualizar('C29', 'TAB_SINAIS_VITAIS__VISUALIZAR'),
  aceitar('B31', 'ACEITAR'),
  atualizar_equipe_veiculo('B32', 'ATUALIZAR_EQUIPE_VEICULO'),
  recusar('B33', 'RECUSAR');

  const ClaimEnum(this.code, this.name);

  final String code;
  final String name;

  @override
  String toString() => 'ClaimsEnum($code, $name)';
}
