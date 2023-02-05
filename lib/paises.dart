import 'package:flutter/material.dart';

class Pais {
  final String nombre;
  final String bandera;
  final String capital;

  Pais({required this.nombre, required this.bandera, required this.capital});
}

final paises = <Pais> [
  Pais(
    nombre: 'Argentina',
    bandera: 'ar.png',
    capital: 'Buenos Aires'
  ),
  Pais(
    nombre: 'Brasil',
    bandera: 'br.png',
    capital: 'Brasilia',
  ),
  Pais(
    nombre: 'Chile',
    bandera: 'cl.png',
    capital: 'Santiago de Chile',
  ),
  Pais(
    nombre: 'Uruguay',
    bandera: 'uy.png',
    capital: 'Montevideo',
  ),
  Pais(
    nombre: 'Paraguay',
    bandera: 'py.png',
    capital: 'Asunción',
  ),
  Pais(
    nombre: 'Bolivia',
    bandera: 'bo.png',
    capital: 'Sucre',
  ),
  Pais(
    nombre: 'Perú',
    bandera: 'pe.png',
    capital: 'Lima',
  ),
  Pais(
    nombre: 'Venezuela',
    bandera: 've.png',
    capital: 'Caracas',
  ),
  Pais(
    nombre: 'Colombia',
    bandera: 'co.png',
    capital: 'Bogotá',
  ),
  Pais(
    nombre: 'Ecuador',
    bandera: 'ec.png',
    capital: 'Quito',
  )
];