//
//  PDFCreator.swift
//  Curriculo
//
//  Created by Gabriele Namie on 28/09/21.
//

import Foundation
import UIKit
import PDFKit

class PDFCreator: NSObject {
    let nome: String
    let nascimento: String
    let tel: String
    let local: String
    let email: String
    let link: String
    let objetivoProf: String
    let resumoProf: String
    let nomeEmp: String
    let cargoEmp: String
    let dataIniEmp: String
    let dataFimEmp: String
    let detalhesEmp: String
    let nomeInst: String
    let cursoInst: String
    let dataIniInst: String
    let dataFimInst: String
    let realizacao: String
    let descReal: String
    let dataIniReal: String
    let dataFimReal: String
    let deficiencia: String
    let deficienciaObs: String
    let modelo: String
    
    init(nome: String, nascimento: String, tel: String, local: String, email: String, link: String, objetivoProf: String, resumoProf: String, nomeEmp: String, cargoEmp: String, dataIniEmp: String, dataFimEmp: String, detalhesEmp: String, nomeInst: String, cursoInst: String, dataIniInst: String, dataFimInst: String, realizacao: String, descReal: String, dataIniReal: String, dataFimReal: String, deficiencia: String, deficienciaObs: String, modelo: String) {
        self.nome = nome
        self.nascimento = nascimento
        self.tel = tel
        self.local = local
        self.email = email
        self.link = link
        self.objetivoProf = objetivoProf
        self.resumoProf = resumoProf
        self.nomeEmp = nomeEmp
        self.cargoEmp = cargoEmp
        self.dataIniEmp = dataIniEmp
        self.dataFimEmp = dataFimEmp
        self.detalhesEmp = detalhesEmp
        self.nomeInst = nomeInst
        self.cursoInst = cursoInst
        self.dataIniInst = dataIniInst
        self.dataFimInst = dataFimReal
        self.realizacao = realizacao
        self.descReal = descReal
        self.dataIniReal = dataIniReal
        self.dataFimReal = dataFimReal
        self.deficiencia = deficiencia
        self.deficienciaObs = deficienciaObs
        self.modelo = modelo
    }
    func criarCurriculo() -> Data {
        // 1
        let pdfMetaData = [
            kCGPDFContextCreator: "Curriculo",
            kCGPDFContextAuthor: "Marcelo",
            kCGPDFContextTitle: nome
        ]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]
        
        // 2
        let paginaLargura = 8.25 * 72.0
        let paginaAltura = 11.75 * 72.0
        let paginaTamanho = CGRect(x: 0, y: 0, width: paginaLargura, height: paginaAltura)
        
        // 3
        let renderer = UIGraphicsPDFRenderer(bounds: paginaTamanho, format: format)
        // 4
        let data = renderer.pdfData { (context) in
            // 5
            context.beginPage()
            // 6
            let titleBottom =
            //forms 1
            addNome(pageRect: paginaTamanho)
            addNascimento(pageRect: paginaTamanho, textTop:  titleBottom + 15)
            addTel(pageRect: paginaTamanho, textTop: titleBottom + 30)
            addEmail(pageRect: paginaTamanho, textTop: titleBottom + 45)
            addLocal(pageRect: paginaTamanho, textTop: titleBottom + 60)
            addLinks(pageRect: paginaTamanho, textTop: titleBottom + 75)
            //forms 2
            addObjetivoProf(pageRect: paginaTamanho, textTop: titleBottom + 90)
            addResumoProf(pageRect: paginaTamanho, textTop: titleBottom + 105)
            //forms 3
            addNomeEmp(pageRect: paginaTamanho, textTop: titleBottom + 125)
            addCargoEmp(pageRect: paginaTamanho, textTop: titleBottom + 140)
            addDataIniEmp(pageRect: paginaTamanho, textTop: titleBottom + 150)
            addDataFimEmp(pageRect: paginaTamanho, textTop: titleBottom + 160)
            addDetalhesEmp(pageRect: paginaTamanho, textTop: titleBottom + 170)
            //forms 4
            addNomeInst(pageRect: paginaTamanho, textTop: titleBottom + 180)
            addCursoInst(pageRect: paginaTamanho, textTop: titleBottom + 190)
            addDataIniInst(pageRect: paginaTamanho, textTop: titleBottom + 200)
            addDataFimInst(pageRect: paginaTamanho, textTop: titleBottom + 210)
            
            addReal(pageRect: paginaTamanho, textTop: titleBottom + 100)
            addDescReal(pageRect: paginaTamanho, textTop: titleBottom + 100)
            addDataIniReal(pageRect: paginaTamanho, textTop: titleBottom + 100)
            addDataFimReal(pageRect: paginaTamanho, textTop: titleBottom + 100)

            
            addDeficiencia(pageRect: paginaTamanho, textTop: titleBottom + 220)
            addDeficienciaObs(pageRect: paginaTamanho, textTop: titleBottom + 240)
        }
        return data
    }
    func addNome(pageRect: CGRect) -> CGFloat {
        let titleFont = UIFont.systemFont(ofSize: 32.0, weight: .heavy)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineBreakMode = .byWordWrapping
//        CTLineBreakMode.byWordWrapping
        let titleAttributes =
        [ NSAttributedString.Key.paragraphStyle: paragraphStyle,
          NSAttributedString.Key.font: titleFont] as [NSAttributedString.Key : Any] as [NSAttributedString.Key : Any]
        
        let attributedTitle = NSAttributedString(string: nome, attributes: titleAttributes)
        let titleStringSize = attributedTitle.size()
        let titleStringRect = CGRect(x: (pageRect.width - titleStringSize.width) / 2.0,
                                     y: 36, width: titleStringSize.width,
                                     height: titleStringSize.height)
        attributedTitle.draw(in: titleStringRect)
        return titleStringRect.origin.y + titleStringRect.size.height
    }
    func addNascimento(pageRect: CGRect, textTop: CGFloat) {
        let fonteNasc = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: fonteNasc            
        ]
        let attributedText = NSAttributedString(string: "Data de nascimento: \(nascimento)", attributes: textAttributes)
        let textRect = CGRect(x: 30, y: textTop, width: pageRect.width - 20,
                              height: pageRect.height - textTop - pageRect.height / 5.0)
        attributedText.draw(in: textRect)
    }
    func addTel(pageRect: CGRect, textTop: CGFloat) {
        let contactTextFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        let contactBlurbAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: contactTextFont
        ]
        let attributedContactText = NSMutableAttributedString(string: "Contato: \(tel)", attributes: contactBlurbAttributes)
        let contactRect = CGRect(x: 30, y: textTop, width: pageRect.width - 20,
                                 height: pageRect.height - textTop - pageRect.height / 5.0)
        attributedContactText.draw(in: contactRect)
    }
    func addEmail(pageRect: CGRect, textTop: CGFloat) {
        // 1
        let textFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        // 2
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        // 3
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        let attributedText = NSAttributedString(string: "Email: \(email)", attributes: textAttributes)
        // 4
        let emailRect = CGRect(x: 30, y: textTop, width: pageRect.width - 20,
                               height: pageRect.height - textTop - pageRect.height / 5.0)
        attributedText.draw(in: emailRect)
    }
    func addLocal(pageRect: CGRect, textTop: CGFloat) {
        // 1
        let textFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        // 2
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        // 3
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        let attributedText = NSAttributedString(string: "Localidade: \(local)", attributes: textAttributes)
        // 4
        let localRect = CGRect(x: 30, y: textTop, width: pageRect.width - 20,
                               height: pageRect.height - textTop - pageRect.height / 5.0)
        attributedText.draw(in: localRect)
    }
    func addLinks(pageRect: CGRect, textTop: CGFloat) {
        // 1
        let textFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        // 2
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        // 3
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        let attributedText = NSAttributedString(string: "Links adicionais: \(link)", attributes: textAttributes)
        // 4
        let linksRect = CGRect(x: 30, y: textTop, width: pageRect.width - 20,
                               height: pageRect.height - textTop - pageRect.height / 5.0)
        attributedText.draw(in: linksRect)
    }
    func addObjetivoProf(pageRect: CGRect, textTop: CGFloat) {
        // 1
        let textFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        // 2
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        // 3
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        let attributedText = NSAttributedString(string: "Objetivo: \(objetivoProf)", attributes: textAttributes)
        // 4
        let objRect = CGRect(x: 30, y: textTop, width: pageRect.width - 20,
                             height: pageRect.height - textTop - pageRect.height / 5.0)
        attributedText.draw(in: objRect)
    }
    func addResumoProf(pageRect: CGRect, textTop: CGFloat) {
        let textFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        let attributedText = NSAttributedString(string: "texto: \(resumoProf)", attributes: textAttributes)
        let textoRect = CGRect(x: 30, y: textTop, width: pageRect.width - 20,
                               height: pageRect.height - textTop - pageRect.height / 5.0)
        attributedText.draw(in: textoRect)
    }
    func addNomeEmp(pageRect: CGRect, textTop: CGFloat) {
        let textFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        let attributedText = NSAttributedString(string: "texto: \(nomeEmp)", attributes: textAttributes)
        let textoRect = CGRect(x: 30, y: textTop, width: pageRect.width - 20,
                               height: pageRect.height - textTop - pageRect.height / 5.0)
        attributedText.draw(in: textoRect)
    }
    func addCargoEmp(pageRect: CGRect, textTop: CGFloat) {
        let textFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        let attributedText = NSAttributedString(string: "texto: \(cargoEmp)", attributes: textAttributes)
        let textoRect = CGRect(x: 30, y: textTop, width: pageRect.width - 20,
                               height: pageRect.height - textTop - pageRect.height / 5.0)
        attributedText.draw(in: textoRect)
    }
    func addDataIniEmp(pageRect: CGRect, textTop: CGFloat) {
        let textFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        let attributedText = NSAttributedString(string: "texto: \(dataIniEmp)", attributes: textAttributes)
        let textoRect = CGRect(x: 30, y: textTop, width: pageRect.width - 20,
                               height: pageRect.height - textTop - pageRect.height / 5.0)
        attributedText.draw(in: textoRect)
    }
    func addDataFimEmp(pageRect: CGRect, textTop: CGFloat) {
        let textFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        let attributedText = NSAttributedString(string: "texto: \(dataFimEmp)", attributes: textAttributes)
        let textoRect = CGRect(x: 30, y: textTop, width: pageRect.width - 20,
                               height: pageRect.height - textTop - pageRect.height / 5.0)
        attributedText.draw(in: textoRect)
    }
    func addDetalhesEmp(pageRect: CGRect, textTop: CGFloat) {
        let textFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        let attributedText = NSAttributedString(string: "texto: \(detalhesEmp)", attributes: textAttributes)
        let textoRect = CGRect(x: 30, y: textTop, width: pageRect.width - 20,
                               height: pageRect.height - textTop - pageRect.height / 5.0)
        attributedText.draw(in: textoRect)
    }
    func addNomeInst(pageRect: CGRect, textTop: CGFloat) {
        let textFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        let attributedText = NSAttributedString(string: "texto: \(nomeInst)", attributes: textAttributes)
        let textoRect = CGRect(x: 30, y: textTop, width: pageRect.width - 20,
                               height: pageRect.height - textTop - pageRect.height / 5.0)
        attributedText.draw(in: textoRect)
    }
    func addCursoInst(pageRect: CGRect, textTop: CGFloat) {
        let textFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        let attributedText = NSAttributedString(string: "texto: \(cursoInst)", attributes: textAttributes)
        let textoRect = CGRect(x: 30, y: textTop, width: pageRect.width - 20,
                               height: pageRect.height - textTop - pageRect.height / 5.0)
        attributedText.draw(in: textoRect)
    }
    
    func addDataIniInst(pageRect: CGRect, textTop: CGFloat) {
        let textFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        let attributedText = NSAttributedString(string: "texto: \(dataIniInst)", attributes: textAttributes)
        let textoRect = CGRect(x: 30, y: textTop, width: pageRect.width - 20,
                               height: pageRect.height - textTop - pageRect.height / 5.0)
        attributedText.draw(in: textoRect)
    }
    func addDataFimInst(pageRect: CGRect, textTop: CGFloat) {
        let textFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        let attributedText = NSAttributedString(string: "texto: \(dataFimInst)", attributes: textAttributes)
        let textoRect = CGRect(x: 30, y: textTop, width: pageRect.width - 20,
                               height: pageRect.height - textTop - pageRect.height / 5.0)
        attributedText.draw(in: textoRect)
    }
    func addReal(pageRect: CGRect, textTop: CGFloat) {
        let textFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        let attributedText = NSAttributedString(string: "texto: \(realizacao)", attributes: textAttributes)
        let textoRect = CGRect(x: 30, y: textTop, width: pageRect.width - 20,
                               height: pageRect.height - textTop - pageRect.height / 5.0)
        attributedText.draw(in: textoRect)
    }
    func addDescReal(pageRect: CGRect, textTop: CGFloat) {
        let textFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        let attributedText = NSAttributedString(string: "texto: \(descReal)", attributes: textAttributes)
        let textoRect = CGRect(x: 30, y: textTop, width: pageRect.width - 20,
                               height: pageRect.height - textTop - pageRect.height / 5.0)
        attributedText.draw(in: textoRect)
    }
    func addDataIniReal(pageRect: CGRect, textTop: CGFloat) {
        let textFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        let attributedText = NSAttributedString(string: "texto: \(dataIniReal)", attributes: textAttributes)
        let textoRect = CGRect(x: 30, y: textTop, width: pageRect.width - 20,
                               height: pageRect.height - textTop - pageRect.height / 5.0)
        attributedText.draw(in: textoRect)
    }
    func addDataFimReal(pageRect: CGRect, textTop: CGFloat) {
        let textFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        let attributedText = NSAttributedString(string: "texto: \(dataFimReal)", attributes: textAttributes)
        let textoRect = CGRect(x: 30, y: textTop, width: pageRect.width - 20,
                               height: pageRect.height - textTop - pageRect.height / 5.0)
        attributedText.draw(in: textoRect)
    }
    func addDeficiencia(pageRect: CGRect, textTop: CGFloat) {
        let textFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        let attributedText = NSAttributedString(string: "texto: \(deficiencia)", attributes: textAttributes)
        let textoRect = CGRect(x: 30, y: textTop, width: pageRect.width - 20,
                               height: pageRect.height - textTop - pageRect.height / 5.0)
        attributedText.draw(in: textoRect)
    }
    
    func addDeficienciaObs(pageRect: CGRect, textTop: CGFloat) {
        let textFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        let attributedText = NSAttributedString(string: "texto: \(deficienciaObs)", attributes: textAttributes)
        let textoRect = CGRect(x: 30, y: textTop, width: pageRect.width - 20,
                               height: pageRect.height - textTop - pageRect.height / 5.0)
        attributedText.draw(in: textoRect)
    }
}
