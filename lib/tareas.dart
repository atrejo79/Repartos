import 'package:flutter/material.dart';
import 'package:to_do_list/main.dart';

class Tarea {
  String _nombre;
  String _estado;

  Tarea(this._nombre, this._estado);

  String get nombre => _nombre;
  String get estado => _estado;

  set nombre(String nuevoNombre) {
    if (nuevoNombre.length <= 255) {
      nombre = nuevoNombre;
    }
  }
  set estado(String nuevoEstado) => _estado = nuevoEstado;
}

class FichaTarea extends StatelessWidget {
  final String titulo, estado;
  FichaTarea ({required this.titulo, required this.estado}) : super();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: <Widget>[
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(titulo, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 20),),
                  Text(estado, style: TextStyle(fontStyle: FontStyle.italic, color: Theme.of(context).primaryColor, fontSize: 15),),
                ],
              )
          )
        ],
      ),
    );
  }
}

class nuevaTarea extends StatefulWidget {
  final Tarea tarea;
  final String appBarTitle;
  ListaTareasState listaTareasState;
  int index;

  nuevaTarea(this.tarea, this.appBarTitle, this.listaTareasState, [this.index = -1]);

  @override
  State<StatefulWidget> createState() {
    return NuevaTareaState(tarea, appBarTitle, listaTareasState, index);
  }
}

class NuevaTareaState extends State<nuevaTarea> {
  Tarea tarea;
  String appBarTitle;
  ListaTareasState listaTareasState;
  int index;
  bool marcado = false;

  NuevaTareaState(this.tarea, this.appBarTitle, this.listaTareasState, this.index);

  TextEditingController tareaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    tareaController.text = tarea.nombre;

    return Scaffold(
      key: GlobalKey<ScaffoldState>(),
      appBar: AppBar(
        leading: GestureDetector(
          child: const Icon(Icons.close),
          onTap: () {
            Navigator.pop(context);
            listaTareasState.actualizarListView();
          },
        ),
        title: Text(appBarTitle),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 50.0),
            child: _estaEditando() ? CheckboxListTile(
              title: const Text("Completada"),
              value: marcado,
              onChanged: (valor) {
                setState(() {
                  marcado = valor!;
                });
              },
            ) : Container(height: 2,)
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: tareaController,
              decoration: const InputDecoration(
                labelText: "Tarea",
                hintText: "Tarea a realizar...",
              ),
              onChanged: (value) {
                actualizaTarea();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              child: const Text("Guardar"),
              onPressed: () {
                setState(() {
                  _guardarTarea();
                });
              },
            ),
          )
        ],
      ),
    );
  }

  bool _estaEditando() {
    bool editando = false;
    if (index != -1) {
      editando = true;
    }
    return editando;
  }

  void actualizaTarea() {
    tarea.nombre = tareaController.text;
  }

  void _guardarTarea() {
    tarea.estado = "";
    if (_estaEditando()) {
      if (marcado) {
        tarea.estado = "Completada";
      }
    }
    tarea.nombre = tareaController.text;

    if (_comprobarNoNull()) {
      if (!_estaEditando()) {
        listaTareasState.listaDeTareas.add(tarea);
      }
      else {
        listaTareasState.listaDeTareas[index] = tarea;
      }
      actualizaTarea();
      Navigator.pop(context);
      mostrarSnackBar("Tarea añadida correctamente");
    }
  }

  bool _comprobarNoNull(){
    bool res = true;
    if (tareaController.text.isEmpty) {
      mostrarSnackBar("La tarea es OBLIGATORIA.");
      res = false;
    }
    return res;
  }

  void mostrarSnackBar(String mensaje) {
    final snackBar = SnackBar(content: Text(mensaje), duration: const Duration(seconds: 1),);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}