// DO NOT EDIT: This file is automagically generated

class Chars {
  static ctrlA{
    return 0x01
  }
  static ctrlB{
    return 0x02
  }
  static ctrlC{
    return 0x03
  }
  static ctrlD{
    return 0x04
  }
  static ctrlE{
    return 0x05
  }
  static ctrlF{
    return 0x06
  }
  static tab{
    return 0x09
  }
  static lineFeed{
    return 0x0a
  }
  static ctrlK{
    return 0x0b
  }
  static ctrlL{
    return 0x0c
  }
  static carriageReturn{
    return 0x0d
  }
  static ctrlN{
    return 0x0e
  }
  static ctrlP{
    return 0x10
  }
  static ctrlU{
    return 0x15
  }
  static ctrlW{
    return 0x17
  }
  static escape{
    return 0x1b
  }
  static space{
    return 0x20
  }
  static bang{
    return 0x21
  }
  static quote{
    return 0x22
  }
  static percent{
    return 0x25
  }
  static amp{
    return 0x26
  }
  static singleQuote{
    return 0x27
  }
  static leftParen{
    return 0x28
  }
  static rightParen{
    return 0x29
  }
  static star{
    return 0x2a
  }
  static plus{
    return 0x2b
  }
  static comma{
    return 0x2c
  }
  static minus{
    return 0x2d
  }
  static dot{
    return 0x2e
  }
  static slash{
    return 0x2f
  }
  static zero{
    return 0x30
  }
  static one{
    return 0x31
  }
  static nine{
    return 0x39
  }
  static less{
    return 0x3c
  }
  static equal{
    return 0x3d
  }
  static greater{
    return 0x3e
  }
  static question{
    return 0x3f
  }
  static upperA{
    return 0x41
  }
  static upperF{
    return 0x46
  }
  static upperO{
    return 0x4f
  }
  static upperZ{
    return 0x5a
  }
  static leftBracket{
    return 0x5b
  }
  static backslash{
    return 0x5c
  }
  static rightBracket{
    return 0x5d
  }
  static caret{
    return 0x5e
  }
  static underscore{
    return 0x5f
  }
  static lowerA{
    return 0x61
  }
  static lowerE{
    return 0x65
  }
  static lowerF{
    return 0x66
  }
  static lowerX{
    return 0x78
  }
  static lowerZ{
    return 0x7a
  }
  static leftBrace{
    return 0x7b
  }
  static pipe{
    return 0x7c
  }
  static rightBrace{
    return 0x7d
  }
  static tilde{
    return 0x7e
  }
  static delete{
    return 0x7f
  }
  static isAlpha(c) {
    return c >= lowerA && c <= lowerZ || c >= upperA && c <= upperZ || c == underscore
  }
  static isDigit(c) {
    return c >= zero && c <= nine
  }
  static isAlphaNumeric(c) {
    return isAlpha(c) || isDigit(c)
  }
  static isHexDigit(c) {
    return c >= zero && c <= nine || c >= lowerA && c <= lowerF || c >= upperA && c <= upperF
  }
  static isLowerAlpha(c) {
    return c >= lowerA && c <= lowerZ
  }
  static isWhitespace(c) {
    return c == space || c == tab || c == carriageReturn
  }
}
