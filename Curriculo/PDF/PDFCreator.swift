//
//  PDFCreator.swift
//  Curriculo
//
//  Created by Gabriele Namie on 28/09/21.
//

import Foundation
import UIKit
import PDFKit

class PDFCreator: NSObject
let nome: String = dictionary["Nome"]!
let nascimento = dictionary["Data"]!
let tel = dictionary["Tel"]!
let local = dictionary["Local"]!
let email = dictionary["Email"]!
let link = dictionary["Link"]!
let objetivoProf = dictionary["Objetivo"]!
let resumoProf = dictionary["Resumo"]!
let nomeEmp = dictionary["NomeEmpresa"]!
let cargoEmp = dictionary["NomeCargo"]!
let dataIniEmp = dictionary["EmpregoDataIni"]!
let dataFimEmp = dictionary["EmpregoDataFim"]!
let detalhesEmp = dictionary["Detalhes"]!
let nomeInst = dictionary["NomeInst"]!
let cursoInst = dictionary["NomeCurso"]!
let dataIniInst = dictionary["InstDataIni"]!
let dataFimInst = dictionary["InstDataFim"]!
let realizacao = dictionary["NomeConq"]!
let descReal = dictionary["DescConq"]!
let dataIniReal = dictionary["ConqDataIni"]!
let dataFimReal = dictionary["ConqDataFim"]!
let deficiencia = dictionary["NomeDef"]!
let deficienciaObs = dictionary["ObsDef"]!
