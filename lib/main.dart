import 'package:flutter/material.dart';
import 'package:to_do_list/paises.dart';
import 'package:to_do_list/tareas.dart';

void main() {
  runApp(const Paises());
}

class Paises extends StatelessWidget {
  const Paises({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tareas',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const ListaDeTareas(),
    );
  }
}

class ListaDeTareas extends StatefulWidget {
  const ListaDeTareas({super.key});

  @override
  State<StatefulWidget> createState() {
    return ListaTareasState();
  }
}

class ListaTareasState extends State<ListaDeTareas> {
  List<Tarea> listaDeTareas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tareas'),
      ),
      body: ListView.builder(
        itemCount: listaDeTareas.length,
        itemBuilder: ((BuildContext context, int index) {
              final item = listaDeTareas[index];

              return GestureDetector(
                onTap: () {
                  _editarTarea(listaDeTareas[index], this, index);
                },
                child: Dismissible (
                  key: Key(item.nombre),
                  onDismissed: (direction) {
                    borrarTarea(index);
                  },
                  child: Card(
                    margin: const EdgeInsets.all(1.0),
                    elevation: 2.0,
                    child: FichaTarea(
                      titulo: item.nombre,
                      estado: item.estado,
                    ),
                  ),
                ),
              );
            }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Añadir tarea",
        onPressed: () {
          _crearTarea(this);
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  void borrarTarea(int index) {
    listaDeTareas.removeAt(index);
    actualizarListView();
  }

  void actualizarListView() {
    setState(() {
      listaDeTareas = listaDeTareas;
    });
  }

  void _editarTarea(Tarea tarea, ListaTareasState obj, int index) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => nuevaTarea(tarea, 'Editar tarea', obj, index)));
    actualizarListView();
  }

  void _crearTarea(ListaTareasState obj) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => nuevaTarea(Tarea("",""), "Añadir tarea", obj)));
    actualizarListView();
  }
}