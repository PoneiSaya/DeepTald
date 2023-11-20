import 'package:deep_tald/model/entity/Item.dart';

class Report {
  late List<ItemMisurabile> _elencoMisurazioni;

  Report.vuoto();
  Report(List<ItemMisurabile> elenco) : _elencoMisurazioni = elenco;

  get getElencoMisurazioni => _elencoMisurazioni;
  set setElencoMisurazioni(List<ItemMisurabile> elenco) =>
      _elencoMisurazioni = elenco;

  ///In questo metodo si aggiunge una misurazione al report///
  void addMisurazione(ItemMisurabile elemento) {
    _elencoMisurazioni.add(elemento);
  }
}
