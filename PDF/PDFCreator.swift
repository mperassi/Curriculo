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
    let cor: String
    
    init(nome: String, nascimento: String, tel: String, local: String, email: String, link: String, objetivoProf: String, resumoProf: String, nomeEmp: String, cargoEmp: String, dataIniEmp: String, dataFimEmp: String, detalhesEmp: String, nomeInst: String, cursoInst: String, dataIniInst: String, dataFimInst: String, realizacao: String, descReal: String, dataIniReal: String, dataFimReal: String, deficiencia: String, deficienciaObs: String, modelo: String, cor: String) {
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
        self.cor = cor
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
            
            let linksBottom =
            addLinks(pageRect: paginaTamanho)
            addObjetivo(pageRect: paginaTamanho, textTop: linksBottom + 10)
            let objBottom =
            addObjetivoProf(pageRect: paginaTamanho)
            addResumo(pageRect: paginaTamanho, textTop: objBottom + 10)
            let resumoBottom =
            addResumoProf(pageRect: paginaTamanho, textTop: objBottom + 30)
            addExperiencia(pageRect: paginaTamanho, textTop: resumoBottom + 10)
//            //forms 3
            let nomeEmpBottom =
            addNomeEmp(pageRect: paginaTamanho, textTop: resumoBottom + 30)
            addCargoEmp(pageRect: paginaTamanho, textTop: nomeEmpBottom - 2)
            addDataIniEmp(pageRect: paginaTamanho, textTop: nomeEmpBottom + 10)
            addDataFimEmp(pageRect: paginaTamanho, textTop: nomeEmpBottom + 10)
            let detalhesBottom =
            addDetalhesEmp(pageRect: paginaTamanho, textTop: nomeEmpBottom + 25)
            addIntituicao(pageRect: paginaTamanho, textTop: detalhesBottom + 10)
            addNomeInst(pageRect: paginaTamanho, textTop: detalhesBottom + 30)
            addCursoInst(pageRect: paginaTamanho, textTop: detalhesBottom + 60)
            addDataIniInst(pageRect: paginaTamanho, textTop: detalhesBottom + 45)
            addDataFimInst(pageRect: paginaTamanho, textTop: detalhesBottom + 45)
            addRealizacao(pageRect: paginaTamanho, textTop: detalhesBottom + 85)
            let realBottom =
            addReal(pageRect: paginaTamanho, textTop: detalhesBottom + 105)
            addDescReal(pageRect: paginaTamanho, textTop: realBottom)
            addDataIniReal(pageRect: paginaTamanho, textTop: realBottom + 15)
            addDataFimReal(pageRect: paginaTamanho, textTop: realBottom + 15)
            addInfoAdd(pageRect: paginaTamanho, textTop: realBottom + 40)
            addDeficiencia(pageRect: paginaTamanho, textTop: realBottom + 60)
            addDeficienciaObs(pageRect: paginaTamanho, textTop: realBottom + 75)
        }
        return data
    }
    func addNome(pageRect: CGRect) -> CGFloat {
        let titleFont = UIFont.systemFont(ofSize: 32.0, weight: .heavy)
        //let titlecolor = UIColor(named: "Ciano")
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.alignment = .center
        paragraphStyle.lineBreakMode = .byWordWrapping
        let titleAttributes =
        [ NSAttributedString.Key.paragraphStyle: paragraphStyle,
          NSAttributedString.Key.font: titleFont,
        ]
        
        let attributedTitle = NSAttributedString(string: nome, attributes: titleAttributes)
        let titleStringSize = attributedTitle.size()
        let titleStringRect = CGRect(x: (pageRect.width - titleStringSize.width) / 2.0,
                                     y: 35, width: titleStringSize.width,
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
    func addLinks(pageRect: CGRect) -> CGFloat {
        // 1
        let textFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        // 2
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        // 3
        let textAttributes =
            [NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont]
        
        let attributedText = NSAttributedString(string: "Links adicionais: \(link)", attributes: textAttributes)
        let titleStringSize = attributedText.size()
        let linksRect = CGRect(x: 30, y: 150, width: titleStringSize.width,height: titleStringSize.height)
        attributedText.draw(in: linksRect)
        return linksRect.origin.y + linksRect.size.height
    }
    func addObjetivo(pageRect: CGRect, textTop: CGFloat) {
        // 1
        let textFont = UIFont.systemFont(ofSize: 16.0, weight: .heavy)
        // 2
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        // 3
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        let attributedText = NSAttributedString(string: "OBJETIVO", attributes: textAttributes)
        
        // 4
        let objRect = CGRect(x: 30, y: textTop, width: pageRect.width - 20,
                             height: pageRect.height - textTop - pageRect.height / 5.0)
        attributedText.draw(in: objRect)
    }
    func addObjetivoProf(pageRect: CGRect) -> CGFloat {
        // 1
        let textFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        // 2
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        // 3
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont,
        ]
        let attributedText = NSAttributedString(string: objetivoProf, attributes: textAttributes)
        // 4
        let paragraphSize = CGSize(width: pageRect.width - 50, height: pageRect.height)
        let paragraphRect = attributedText.boundingRect(with: paragraphSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        let objRect = CGRect(x: 30, y: 195, width: paragraphRect.width, height: paragraphRect.height)
        attributedText.draw(in: objRect)
        return objRect.origin.y + objRect.size.height
    }
    func addResumo(pageRect: CGRect, textTop: CGFloat) {
        let textFont = UIFont.systemFont(ofSize: 16.0, weight: .heavy)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        let attributedText = NSAttributedString(string: "RESUMO PROFISSIONAL", attributes: textAttributes)
        let textoRect = CGRect(x: 30, y: textTop, width: pageRect.width - 20,
                               height: pageRect.height - textTop - pageRect.height / 5.0)
        attributedText.draw(in: textoRect)
    }
    func addResumoProf(pageRect: CGRect, textTop: CGFloat) -> CGFloat {
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
        let attributedText = NSAttributedString(string: resumoProf, attributes: textAttributes)
        let paragraphSize = CGSize(width: pageRect.width - 50, height: pageRect.height)
        let paragraphRect = attributedText.boundingRect(with: paragraphSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        // 4
        let resumoRect = CGRect(x:30, y: textTop , width: paragraphRect.width, height: paragraphRect.height)
        attributedText.draw(in: resumoRect)
        return resumoRect.origin.y + resumoRect.size.height
    }
    func addExperiencia(pageRect: CGRect, textTop: CGFloat) {
        let textFont = UIFont.systemFont(ofSize: 16.0, weight: .heavy)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        let attributedText = NSAttributedString(string: "EXPERIÊNCIA DE TRABALHO", attributes: textAttributes)
        let textoRect = CGRect(x: 30, y: textTop, width: pageRect.width - 20,
                               height: pageRect.height - textTop - pageRect.height / 5.0)
        attributedText.draw(in: textoRect)
    }
    func addNomeEmp(pageRect: CGRect,textTop: CGFloat) -> CGFloat {
        // 1
        let textFont = UIFont.systemFont(ofSize: 14.0, weight: .bold)
        // 2
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        // 3
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        let attributedText = NSAttributedString(string: nomeEmp, attributes: textAttributes)
        // 4
        
        let paragraphSize = CGSize(width: pageRect.width - 50, height: pageRect.height)
        let paragraphRect = attributedText.boundingRect(with: paragraphSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        let resumoRect = CGRect(x: 30, y: textTop, width: paragraphRect.width,height: paragraphRect.height)
        attributedText.draw(in: resumoRect)
        return resumoRect.origin.y + resumoRect.size.height
    }
    func addCargoEmp(pageRect: CGRect, textTop: CGFloat) {
        let textFont = UIFont.systemFont(ofSize: 12.0, weight: .semibold)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        let attributedText = NSAttributedString(string: cargoEmp, attributes: textAttributes)
        let paragraphSize = CGSize(width: pageRect.width - 50, height: pageRect.height)
        let paragraphRect = attributedText.boundingRect(with: paragraphSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        let textoRect = CGRect(x: 30, y: textTop, width: paragraphRect.width,
                               height: paragraphRect.height)
        attributedText.draw(in: textoRect)
    }
    func addDataIniEmp(pageRect: CGRect, textTop: CGFloat) {
        let textFont = UIFont.systemFont(ofSize: 12.0, weight: .semibold)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        let attributedText = NSAttributedString(string:"Inicio\(dataIniEmp)", attributes: textAttributes)
        let textoRect = CGRect(x: 30, y: textTop, width: pageRect.width - 20,
                               height: pageRect.height - textTop - pageRect.height / 5.0)
        attributedText.draw(in: textoRect)
    }
    func addDataFimEmp(pageRect: CGRect, textTop: CGFloat) {
        let textFont = UIFont.systemFont(ofSize: 12.0, weight: .semibold)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        let attributedText = NSAttributedString(string: "Fim:\(dataFimEmp)", attributes: textAttributes)
        let textoRect = CGRect(x: 130, y: textTop, width: pageRect.width - 20,
                               height: pageRect.height - textTop - pageRect.height / 5.0)
        attributedText.draw(in: textoRect)
    }
    func addDetalhesEmp(pageRect: CGRect, textTop: CGFloat) -> CGFloat {
        // 1
        let textFont = UIFont.systemFont(ofSize: 13.0, weight: .regular)
        // 2
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        // 3
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        let attributedText = NSAttributedString(string: detalhesEmp, attributes: textAttributes)
        // 4
    
        let paragraphSize = CGSize(width: pageRect.width - 50, height: pageRect.height)
        let paragraphRect = attributedText.boundingRect(with: paragraphSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        let resumoRect = CGRect(x: 30, y: textTop, width: paragraphRect.width,height: paragraphRect.height)
        attributedText.draw(in: resumoRect)
        return resumoRect.origin.y + resumoRect.size.height
    }
    func addIntituicao(pageRect: CGRect, textTop: CGFloat) {
        let textFont = UIFont.systemFont(ofSize: 16.0, weight: .heavy)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        let attributedText = NSAttributedString(string: "ESCOLARIDADE", attributes: textAttributes)
        let textoRect = CGRect(x: 30, y: textTop, width: pageRect.width - 20,
                               height: pageRect.height - textTop - pageRect.height / 5.0)
        attributedText.draw(in: textoRect)
    }
    func addNomeInst(pageRect: CGRect, textTop: CGFloat) {
        let textFont = UIFont.systemFont(ofSize: 13.0, weight: .bold)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        let attributedText = NSAttributedString(string: (nomeInst), attributes: textAttributes)
        let paragraphSize = CGSize(width: pageRect.width - 50, height: pageRect.height)
        let paragraphRect = attributedText.boundingRect(with: paragraphSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        let textoRect = CGRect(x: 30, y: textTop, width: paragraphRect.width,
                               height: paragraphRect.height)
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
        let attributedText = NSAttributedString(string: (cursoInst), attributes: textAttributes)
        let paragraphSize = CGSize(width: pageRect.width - 50, height: pageRect.height)
        let paragraphRect = attributedText.boundingRect(with: paragraphSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        let textoRect = CGRect(x: 30, y: textTop, width: paragraphRect.width,
                               height: paragraphRect.height)
        attributedText.draw(in: textoRect)
    }
    
    func addDataIniInst(pageRect: CGRect, textTop: CGFloat) {
        let textFont = UIFont.systemFont(ofSize: 12.0, weight: .semibold)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        let attributedText = NSAttributedString(string: "Inicio: \(dataIniInst)", attributes: textAttributes)
        let textoRect = CGRect(x: 30, y: textTop, width: pageRect.width - 20,
                               height: pageRect.height - textTop - pageRect.height / 5.0)
        attributedText.draw(in: textoRect)
    }
    func addDataFimInst(pageRect: CGRect, textTop: CGFloat) {
        let textFont = UIFont.systemFont(ofSize: 12.0, weight: .semibold)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        let attributedText = NSAttributedString(string: "Fim: \(dataFimInst)", attributes: textAttributes)
        let textoRect = CGRect(x: 130, y: textTop, width: pageRect.width - 20,
                               height: pageRect.height - textTop - pageRect.height / 5.0)
        attributedText.draw(in: textoRect)
    }
    func addRealizacao(pageRect: CGRect, textTop: CGFloat) {
        let textFont = UIFont.systemFont(ofSize: 16.0, weight: .heavy)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        let attributedText = NSAttributedString(string: "REALIZAÇÕES", attributes: textAttributes)
        let textoRect = CGRect(x: 30, y: textTop, width: pageRect.width - 20,
                               height: pageRect.height - textTop - pageRect.height / 5.0)
        attributedText.draw(in: textoRect)
    }
    func addReal(pageRect: CGRect,textTop: CGFloat) -> CGFloat {
        // 1
        let textFont = UIFont.systemFont(ofSize: 14.0, weight: .bold)
        // 2
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        // 3
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        let attributedText = NSAttributedString(string: realizacao, attributes: textAttributes)
        // 4
        
        let paragraphSize = CGSize(width: pageRect.width - 50, height: pageRect.height)
        let paragraphRect = attributedText.boundingRect(with: paragraphSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        let resumoRect = CGRect(x: 30, y: textTop, width: paragraphRect.width,height: paragraphRect.height)
        attributedText.draw(in: resumoRect)
        return resumoRect.origin.y + resumoRect.size.height
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
        let attributedText = NSAttributedString(string:(descReal), attributes: textAttributes)
        let textoRect = CGRect(x: 30, y: textTop, width: pageRect.width - 20,
                               height: pageRect.height - textTop - pageRect.height / 5.0)
        attributedText.draw(in: textoRect)
    }
    func addDataIniReal(pageRect: CGRect, textTop: CGFloat) {
        let textFont = UIFont.systemFont(ofSize: 12.0, weight: .bold)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        let attributedText = NSAttributedString(string: "Inicial: \(dataIniReal)", attributes: textAttributes)
        let textoRect = CGRect(x: 30, y: textTop, width: pageRect.width - 20,
                               height: pageRect.height - textTop - pageRect.height / 5.0)
        attributedText.draw(in: textoRect)
    }
    func addDataFimReal(pageRect: CGRect, textTop: CGFloat) {
        let textFont = UIFont.systemFont(ofSize: 12.0, weight: .bold)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        let attributedText = NSAttributedString(string: "Final: \(dataFimReal)", attributes: textAttributes)
        let textoRect = CGRect(x: 130, y: textTop, width: pageRect.width - 20,
                               height: pageRect.height - textTop - pageRect.height / 5.0)
        attributedText.draw(in: textoRect)
    }
    func addInfoAdd(pageRect: CGRect, textTop: CGFloat) {
        let textFont = UIFont.systemFont(ofSize: 16.0, weight: .heavy)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        let textAttributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        let attributedText = NSAttributedString(string: "INFORMAÇÕES ADICIONAIS", attributes: textAttributes)
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
        let attributedText = NSAttributedString(string:(deficiencia), attributes: textAttributes)
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
        let attributedText = NSAttributedString(string:(deficienciaObs), attributes: textAttributes)
        let textoRect = CGRect(x: 30, y: textTop, width: pageRect.width - 20,
                               height: pageRect.height - textTop - pageRect.height / 5.0)
        attributedText.draw(in: textoRect)
    }
}
