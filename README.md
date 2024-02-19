<div align="center">

## Curso: [Stanford CS193p](https://cs193p.sites.stanford.edu)

### Desenvolvimento de Aplicativos para IOS

### Primavera de 2020

### Paul Hegarty: [E-mail](phegarty@stanford.edu) | [Piazza](https://piazza.com/professors/show/paul_hegarty)
#### Período de estudos: 13/12/2020  - 06/08/2021

</div>

<br>

<div align="center">
<img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/mrdouglasmorais/Stanford-CS193p">
</div>

<br>

<div align="center">
<img alt="" src="https://img.shields.io/github/issues/mrdouglasmorais/Stanford-CS193p">
<img alt="" src="https://img.shields.io/github/forks/mrdouglasmorais/Stanford-CS193p">
<img alt="" src="https://img.shields.io/github/stars/mrdouglasmorais/Stanford-CS193p">
<img alt="" src="https://img.shields.io/github/license/mrdouglasmorais/Stanford-CS193p">
</div>
<br>
<div align=center>
<a href="https://wakatime.com/badge/user/1e53636e-c916-4d50-9ce1-f3ac75a883e3/project/26df6be5-6b02-4bea-a081-a0529e40c918"><img src="https://wakatime.com/badge/user/1e53636e-c916-4d50-9ce1-f3ac75a883e3/project/26df6be5-6b02-4bea-a081-a0529e40c918.svg" alt="wakatime"></a>
</div>

<br>

#### [Acesse a playlist do Youtube com o conteúdo do curso](https://www.youtube.com/playlist?list=PLMdYygf53DP46rneFgJ7Ab6fJPcMvr8gC)

<br>

> É importante destacar que no primeiro vídeo da playlist indicada acima, o [Filipe Deschamps](https://github.com/filipedeschamps) mostra uma forma de assistir os vídeos com legenda automática em português - Brasil. 
>
> A Stanford disponibilizou gratuitamente todo o material, porém está completamente em inglês. No entanto, no decorrer do meu aprendizado, irei disponibilizando um PDF para cada tarefa necessária em português para avançar as etapas, em que eu irei traduzindo.

<img width="auto" src="https://github.com/mrdouglasmorais/Stanford-CS193p/blob/main/DMS-CS193p-2020-Cover.png?raw=true"> 


#### Sumário [PT-BR]

- [x] Aula 01: Introdução ao Swift e SwiftUI
- [x] Aula 02: MVVM e sistema de tipos de dados em Swift
- [x] Aula 03: UI reativa + Protocolos + Layout
- [x] Aula 04: Grid + Enum + Optionais
- [x] Aula 05: Construtor de visual. + Forma + Modificador de visual.
- [x] Aula 06: Animações
- [x] Aula 07: Multithreading EmojiArt
- [x] Aula 08: Gestos multitoques e JSON
- [x] Aula 09: Fluxo de dados
- [x] Aula 10: Navegação + Campo de texto
- [x] Aula 11: Selecionador
- [x] Aula 12: Núcleo de dados
- [x] Aula 13: Persistência
- [x] Aula 14: Integração com o UIKit

<details>
  <summary>Sumário [EN-USA]</summary>
  
- [x] Lecture 01: Course Logistics and Introduction to SwiftUI
- [x] Lecture 02: MVVM and the Swift Type System
- [x] Lecture 03: Reactive UI + Protocols + Layout
- [x] Lecture 04: Grid + enum + Optionals
- [x] Lecture 05: ViewBuilder + Shape + ViewModifier
- [x] Lecture 06: Animation
- [x] Lecture 07: Multithreading EmojiArt
- [x] Lecture 08: Gestures JSON
- [x] Lecture 09: Data Flow
- [x] Lecture 10: Navigation + TextField
- [x] Lecture 11: Picker
- [x] Lecture 12: Core Data
- [x] Lecture 13: Persistence
- [x] Lecture 14: UIKit Integration
  
</details>

<hr>

#### Carga horária: Aproximadamente 20hs de curso.


#### Aplicativos desenvolvidos

<img width=100 src="https://github.com/mrdouglasmorais/Stanford-CS193p/blob/main/iconsApp/JoyStickAppIconRounded.png?raw=true"> 

<h4><b>Memorize</b></h4>

<details>
  <summary>Descrição do aplicativo</summary>
  
> O aplicativo desenvolvido é um jogo da memória, utilizando emojis como sendo o conteúdo das cartas a serem combinadas. Após terminar de encontrar todas as combinações, o usuário deve pressionar o botão de **New Game** para o app realizar uma nova combinação. 
> 
> Neste app, também foram implementadas: animações, como por exemplo, de cartas sendo viradas ao serem tocadas; inicialização de um temporizador para combinação de duas cartas iguais; adequcão aos modos claro e escuro, que são nativos do sistema; E suporte a rotação de tela.
  
  <hr>
</details>

<details>
    <summary>Código de exemplo</summary>

> MemoryGame.swift

```swift

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only}
        set {
            for index in cards.indices {
                    cards[index].isFaceUp = index == newValue
                }
            }
        }
    
    mutating func choose(card: Card) {
        print("card chosen: \(card)")
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                self.cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
    }

    struct Card: Identifiable {
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }

        var content: CardContent
        var id: Int
        var bonusTimeLimit: TimeInterval = 6

        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }

        var lastFaceUpDate: Date?
        var pastFaceUpTime: TimeInterval = 0
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }

        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }

        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }

        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }

        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }

        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
}


```


</details>

<img width=100 src="https://github.com/mrdouglasmorais/Stanford-CS193p/blob/main/iconsApp/GhostAppIconRounded.png?raw=true"> 


<h4><b>Emoji Art</b></h4>

<details>
  <summary>Descrição ddo aplicativo</summary>
  
> O aplicativo desenvolvido é destinado a criar imagens personalizadas com emojis. As imagens são obtidas a partir do link de endereço da imagem na internet. O usuário pode criar novas paletas de emojis ou editar as paletas já existentes. 
> 
> Neste app, também foram implementadas: edição do nome de cada seção de criação, exclusão de seção de criação, suporte ao iOS e iPadOS, suporte a gestos de pinça e zoom in / zoom out.
  
  <hr>

</details>


<details>
    <summary>Código de exemplo</summary>

> EmojiArt.swift

```swift

import Foundation

struct EmojiArt: Codable {
    var backgroundURL: URL?
    var emojis = [Emoji]()
    
    struct Emoji: Identifiable, Codable, Hashable {
        let text: String
        var x: Int
        var y: Int
        var size: Int
        let id: Int
        
        fileprivate init(text: String, x: Int, y: Int, size: Int, id: Int) {
            self.text = text
            self.x = x
            self.y = y
            self.size = size
            self.id = id
        }
    }
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    init?(json: Data?) {
        if json != nil, let newEmojiArt = try? JSONDecoder().decode(EmojiArt.self, from: json!) {
            self = newEmojiArt
        } else {
            return nil
        }
    }
    
    init() { }
    
    private var uniqueEmojiId = 0
    
    mutating func addEmoji(_ text: String, x: Int, y: Int, size: Int) {
        uniqueEmojiId += 1
        emojis.append(Emoji(text: text, x: x, y: y, size: size, id: uniqueEmojiId))
    }
}

```

</details>


<img width=100 src="https://github.com/mrdouglasmorais/Stanford-CS193p/blob/main/iconsApp/MapAppIconRounded.png?raw=true"> 


<h4><b>Enroute</b></h4>


<details>
  <summary>Descrição do aplicativo</summary>
  
> O aplicativo desenvolvido é um agregador de voos para cidades diferentes de países diferentes. As informações de voo são obtidas em tempo real a partir do consumo de uma API.
> 
> Neste app, também foram implementadas: filtro de voos contendo opções de busca por aeroportos, cidades de origem e destino e etc.

</details>


<details>
    <summary>Código de exemplo</summary>

> EnroutApp.swift


```swift

import SwiftUI

@main
struct EnrouteApp: App {
    let persistenceController = PersistenceController.shared
    let defaultAirport: Airport
    
    init() {
        defaultAirport = Airport.withICAO("KSFO", context: PersistenceController.shared.container.viewContext)
        defaultAirport.fetchIncomingFlights()
    }

    var body: some Scene {
        WindowGroup {
            FlightsEnrouteView(flightSearch: FlightSearch(destination: defaultAirport))
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

````

</details>


<hr>

##### Conhecimentos obtidos:
- [x] Swift 5.3
- [x] SwiftUI
- [x] Arquitetura MVVM
- [x] Xcode 12
- [x] Xcode simulator
- [x] Core Data

<hr>

<div align="center">
  <img alt="M E M O R I Z E" width="250" src="https://github.com/mrdouglasmorais/Stanford-CS193p/blob/main/gifsApp/Memorize.gif?raw=true">
  <img alt="E M O J I A R T" width="250" src="https://github.com/mrdouglasmorais/Stanford-CS193p/blob/main/gifsApp/EmojiArt.gif?raw=true">
  <img alt="E N R O U T E" width="250" src="https://github.com/mrdouglasmorais/Stanford-CS193p/blob/main/gifsApp/Enroute.gif?raw=true">
</div>

<div align="center">
<img alt="E M O J I A R T" width="auto" src="https://github.com/mrdouglasmorais/Stanford-CS193p/blob/main/gifsApp/EmojiArt-iPadOS.gif?raw=true">
</div>

<hr>

#### Resumo das aulas:

<details>
  <summary>Lecture | Aula 01:</summary>
A primeira das palestras ministradas a alunos da Universidade de Stanford que fizeram CS193p, Desenvolvimento de aplicativos para iOS usando SwiftUI, durante o trimestre da primavera de 2020.

Paul Hegarty cobre a logística do curso e, em seguida, mergulha direto na criação de um aplicativo iOS (um jogo de correspondência de cartas chamado Memorize). O ambiente de desenvolvimento Xcode é usado para demonstrar os fundamentos da interface declarativa do SwiftUI para compor interfaces de usuário.

Observe que este não é um curso online ativo. É um lançamento de vídeos de palestras que já foram dados aos alunos de Stanford como parte de seu currículo normal.
  <hr>
</details>

<details>
  <summary>Lecture | Aula 02:</summary>
A série de aulas em vídeo ministradas aos alunos da Universidade de Stanford na primavera de 2020 continua com uma visão geral conceitual do paradigma arquitetônico subjacente ao desenvolvimento de aplicativos para iOS: MVVM. Além disso, um conceito-chave na linguagem de programação Swift, seu sistema de tipos, é explicado. A demonstração Memorize continua, incorporando MVVM.

É impossível desenvolver aplicativos para iOS usando SwiftUI sem usar a arquitetura MVVM para organizar seu código. Esta palestra explica o que é isso e, em seguida, demonstra como funciona em nosso aplicativo de demonstração. O desenvolvimento do SwiftUI acontece inteiramente na linguagem de programação Swift. O Swift é único em seu suporte à maioria dos recursos de linguagem modernos, incluindo programação orientada a objetos e programação funcional. 
  
Uma vez que a programação funcional é nova para a maioria dos alunos de Stanford, esta palestra inicia o processo de explicar como funciona, cobrindo os fundamentos do sistema de tipos do Swift, incluindo estruturas e classes, genéricos e funções como tipos. A demonstração então passa para o próximo nível usando a arquitetura MVVM (incluindo a criação de um Model, um ViewModel, expressando a intenção do usuário a partir da View) e utilizando recursos do Swift como genéricos e funções como tipos. Após esta aula, os alunos assumem o desenvolvimento do Memorize para sua primeira tarefa.

Os materiais arquivados do curso (tarefas de casa e slides de aula) estão disponíveis em https://cs193p.stanford.edu.
  <hr>
</details>

<details>
  <summary>Lecture | Aula 03:</summary>
A terceira das palestras ministradas aos alunos de Stanford no trimestre da primavera de 2020 demonstra os mecanismos que suportam o paradigma de IU reativo do SwiftUI, aprimorando o Memorize para virar os cartões quando eles são tocados. Os protocolos, um recurso importante da linguagem Swift, são abordados em detalhes, assim como algumas APIs para o layout de visualizações, incluindo as “Pilhas”, modificadores de visualização e GeometryReader.

Um princípio fundamental do MVVM no SwiftUI é a abordagem reativa e declarativa para construir UIs. A visão de nosso MVVM está sempre refletindo automaticamente o estado em nosso modelo, criando uma única fonte de "verdade" para o coração da lógica e do armazenamento do aplicativo. Somado a isso, formalizamos o conceito de capturar a "intenção" do usuário de fazer algo e usar isso para alterar o modelo de forma adequada. Voltando à nossa demonstração, aplicamos isso ao nosso aplicativo Memorize usando @ObservedObject e @Published para fazer com que os gestos de toque façam os cartões virar. 
  
Depois disso, voltamos a explorar um tópico muito importante de programação orientada a protocolo / funcional: protocolos. Finalmente, examinamos muitas das maneiras pelas quais podemos definir os elementos gráficos de nossa IU na tela, de HStack, VStack e ZStack, alinhamento e espaçamento, e GeometryReader, um mecanismo para ajustar nossa aparência ao espaço alocado para nós no UI.
  <hr>
</details>

<details>
  <summary>Lecture | Aula 04:</summary>
A quarta aula em vídeo dada aos alunos de Stanford no trimestre da primavera de 2020 continua a demonstração Memorize, aprimorando significativamente o arranjo dos cartões, criando nosso próprio container View chamado Grid (que também envolve vários conceitos básicos de programação funcional). Dois recursos mais importantes da linguagem Swift são discutidos (enum e opcionais). E finalmente conseguimos Memorize jogar o próprio jogo de correspondência de cartas (com destaque para os opcionais em nossa implementação).

A pesquisa do sistema de tipo Swift é concluída com uma discussão sobre enum, uma estrutura de dados com mais funcionalidade incorporada do que os alunos estão acostumados em outras linguagens. Embora as tarefas de leitura neste curso sejam a principal forma de os alunos aprenderem a linguagem Swift, ocasionalmente uma característica muito importante da linguagem é destacada na aula, como nesta aula, onde os opcionais são explicados em detalhes e, em seguida, amplamente demonstrados à medida que os usamos proeminentemente em nossa implementação da lógica completa do jogo para Memorizar em nosso modelo.
  <hr>
</details>

<details>
  <summary>Lecture | Aula 05:</summary>
A quinta palestra iOS dada em Stanford durante o trimestre da primavera de 2020 expandiu a cobertura de tópicos relacionados ao desenho na tela, incluindo a construção @ViewBuilder para expressar uma lista condicional de Views, o protocolo Shape para desenho personalizado e ViewModifier, um mecanismo para fazer modificações incrementais para Visualizações.

Esta palestra começa com um aparte sobre controle de acesso (marcação de APIs para que sejam reveladas ao “público” certo dentro de um aplicativo) que é então aplicado em todo o Memorize. Depois que o protocolo de forma é discutido, uma “forma de torta” é adicionada ao plano de fundo dos cartões Memorizar na demonstração em preparação para a animação de um cronômetro de contagem regressiva para pontuação. Um ViewModifier personalizado também é adicionado ao Memorize para "cardificar" qualquer visualização (ou seja, fazer a visualização parecer estar em um cartão com frente e verso).
  <hr>
</details>

<details>
  <summary>Lecture | Aula 06:</summary>
Animação foi o tema da aula 6 do curso de desenvolvimento de aplicativos iOS da Stanford Spring 2020. Depois de abordar alguns tópicos auxiliares, como estado efêmero local em Views (@State) e observadores de propriedade, a palestra se aprofunda em animação, incluindo animações implícitas vs. explícitas, transições, animações de forma, ViewModifiers animados e muito mais. Esses conceitos são então instalados na demonstração Memorize, animando a virada de cartas, criando um novo jogo e dando pontos de bônus para partidas rápidas.

No SwiftUI, qualquer alteração em ViewModifiers ou Shapes pode ser animada. As visualizações podem animar mudanças implícita (usando a declaração de animação) ou explicitamente (envolvendo uma chamada de função withAnimation em torno do código que pode causar mudanças, principalmente funções Intent no ViewModel) e podem controlar a duração e a "curva" da animação. A “chegada e partida” de Views na tela também pode ser animada usando a declaração de transição (que declara quais ViewModifiers usar para desenhar Views antes / depois de chegar / sair da tela). No Memorize, o Cardify ViewModifier e o Pie Shape são ambos feitos Animatable e a animação é aplicada por toda parte.
  <hr>
</details>

<details>
  <summary>Lecture | Aula 07:</summary>
A aula 7 do curso de desenvolvimento iOS de Stanford da primavera de 2020 começa com uma discussão conceitual de multithreading e, em seguida, inicia em uma demonstração completamente nova, EmojiArt, revisando MVVM e usando SwiftUI API como ScrollView, UIImage, Drag and Drop e background / overlay para criar uma ferramenta de “artista de emoji”. A demonstração volta ao multithreading, mostrando como usar essa tecnologia para evitar que o download de uma imagem da Internet bloqueie a capacidade de resposta do aplicativo.
  <hr>
</details>

<details>
  <summary>Lecture | Aula 08:</summary>
A aula 8 do curso de desenvolvimento iOS de Stanford na primavera de 2020 cobre alguns tópicos de persistência (API UserDefaults e codificação / decodificação JSON) e os fundamentos conceituais da manipulação de gestos multitoque. Começamos a adicionar esses recursos ao EmojiArt tornando seu modelo conversível de / para JSON (usando o protocolo Codable) e, em seguida, armazenando-o (por enquanto) em um veículo de armazenamento leve. Depois disso, os gestos de pinçar e arrastar são adicionados ao EmojiArt para permitir ao usuário aumentar e diminuir o zoom e deslocar o documento.
  <hr>
</details>

<details>
  <summary>Lecture | Aula 09:</summary>
Aula 9 do curso de desenvolvimento iOS de Stanford da primavera de 2020 cobre os fundamentos do fluxo de dados, incluindo editores e vinculações. Esses mecanismos permitem referências formalizadas à “verdade” dos dados, em vez de exigir que sejam replicados, o que pode estar sujeito a erros. Uma explicação básica dos wrappers de propriedades ajuda a esclarecer sobre o que são @ObservedObject, @EnvironmentObject, @Published, @State, @Binding, etc. 
  
A demonstração mostra a publicação da chegada da imagem de plano de fundo para nosso documento EmojiArt, bem como o salvamento automático do documento quando as alterações são notadas (ou seja, publicadas). Por fim, nossa interface do usuário foi aprimorada para nos permitir escolher entre várias paletas de emoji, nas quais um Binding é usado para vincular nosso novo seletor de paletas à interface do EmojiArt principal.
  <hr>
</details>

<details>
  <summary>Lecture | Aula 10:</summary>
A décima palestra do curso CS193p da Primavera 2020 de Stanford é uma demonstração imersiva que ilustra uma miríade de recursos SwiftUI, incluindo TextFields, Formulários, NavigationViews, Listas, planilhas, popovers, Alertas, modo de edição e muito mais. Em particular, começamos adicionando um popover com um Form ao nosso documento EmojiArt que permite editar a paleta de emoji. O Grid do Memorize é trazido e renovado usando a funcionalidade genérica avançada para exibir o emoji no editor de paleta. 
  
Em seguida, abordamos como adicionar vários MVVM ViewModels a um único aplicativo iOS e navegar entre essas visualizações usando NavigationViews e NavigationLinks. Isso permite a adição de um armazenamento EmojiArtDocument que permite aos usuários manter o controle de vários EmojiArtDocuments. Concluímos corrigindo alguns bugs e adicionando a funcionalidade de edição e exclusão ao armazenamento EmojiArtDocument.
  <hr>
</details>

<details>
  <summary>Lecture | Aula 11:</summary>
A 11ª aula da versão Primavera 2020 de Stanford de seu curso de desenvolvimento para iOS é a primeira da série final de quatro aulas, todas apresentando tópicos destinados a ajudar os alunos em seus projetos finais. O selecionador, um elemento da IU para escolher em uma lista de itens, é o tópico principal aqui, mas uma base de código de demonstração, Enroute, é apresentada ao longo do caminho em preparação para a próxima aula. 
  
O Enroute é um aplicativo simples que extrai informações da Internet usando uma API REST no formato JSON (embora esse não seja o tópico principal desta palestra). Esta demonstração inclui uma revisão da apresentação de uma IU por meio de uma folha modal usando NavigationView, Form, Toggle, etc.
  <hr>
</details>

<details>
  <summary>Lecture | Aula 12:</summary>
Na segunda da série final de quatro palestras destinadas a ajudar os alunos no curso de desenvolvimento de iOS de Stanford da Primavera de 2020 com seus projetos finais, um poderoso banco de dados orientado a objetos, Core Data, é usado para aprimorar o aplicativo Enroute apresentado anteriormente. Até o momento no curso, o único local de armazenamento era UserDefaults, que era usado principalmente para oferecer suporte a demonstrações de outros recursos e não é realmente apropriado para armazenar os dados reais que um aplicativo coleta ou gera. Esta aula e a próxima cobrem algumas opções melhores de armazenamento. Core Data é provavelmente o mecanismo de armazenamento de dados local mais comumente usado no iOS e tem uma integração elegante com o SwiftUI.

Aula 12 do curso de Desenvolvimento de iOS de Stanford das capas da primavera de 2020.
  <hr>
</details>

<details>
  <summary>Lecture | Aula 13:</summary>
A penúltima palestra do curso de desenvolvimento de iOS da Primavera de 2020 de Stanford cobre mais maneiras de armazenar dados, incluindo no iCloud via CloudKit e no próprio sistema de arquivos do dispositivo iOS. CloudKit é um mecanismo para armazenar os dados do usuário na nuvem para que apareçam em todos os seus dispositivos. Os tipos de dados relevantes são discutidos, bem como os fundamentos de sua API para criar registros, consultá-los e interagir com eles em seu código. Embora não tenha havido tempo para fazer uma demonstração do CloudKit neste trimestre, fazemos uma demonstração do acesso ao sistema de arquivos nesta aula, aprimorando o EmojiArt para armazenar seus documentos lá.
  <hr>
</details>

<details>
  <summary>Lecture | Aula 14:</summary>
Na palestra final do curso de desenvolvimento iOS de Stanford da primavera de 2020, discutimos e demonstramos a integração com a geração anterior do ambiente de desenvolvimento iOS, UIKit. Há muito código UIKit por aí no mundo e ser capaz de começar a usar o SwiftUI enquanto ainda se integra a esse código é crucial. Além disso, existem algumas APIs UIKit que suportam funcionalidades (ainda) que não estão no SwiftUI. 
  
Depois de uma explicação muito básica de como o UIKit faz algumas coisas que são diferentes do SwiftUI (especialmente a delegação), a API em SwiftUI para integrar o código do UIKit é explicada. Duas de nossas demonstrações existentes são então aprimoradas usando este mecanismo: um mapa é adicionado ao Enroute para mostrar e escolher o aeroporto de destino e o EmojiArt oferece suporte ao uso da câmera do dispositivo para tirar uma foto e usar como imagem de fundo.
</details>

---

### Créditos

- [x] [Richard Horvath | Product Designer](https://orwhat.cc) : [Figma | Template iPhone SE 2 Generation 2020](https://www.figma.com/community/file/882254519102673494/Flat-iPhone-SE%2C-7%2C-8%2C-X%2C-11%2C-12-Pro-Mockup)
- [x] [SVG REPO | Gamepad Joystick Vector SVG Icon](https://www.svgrepo.com/svg/275640/gamepad-joystick) : Memorize App Icon
- [x] [SVG REPO | Ghost Vector SVG Icon](https://www.svgrepo.com/svg/312257/ghost) : Emoji Art App Icon
- [x] [SVG REPO | Route Vector SVG Icon](https://www.svgrepo.com/svg/19537/route) : Enroute App Icon
- [x] [Shields.io | Badges Info from Github](https://img.shields.io)

---

> ### Caso você queira ajudar a melhorar este repositório, qualquer ajuda é bem vinda.


- [x] Faça um **fork** deste repositório (https://github.com/mrdouglasmorais/Stanford-CS193p/fork);
- [x] Crie um **branch** com as suas modificações ` git checkout -b meu-novo-recurso `;
- [x] Faça um **commit** ` git commit -am 'Adicionando um novo recurso ...'`;
- [x] Faça um **push** ` git push origin meu-novo-recurso ` ;
- [x] Crie uma nova **pull request** neste repositório.

**Depois que sua solicitação (pull request) for aceita e adicionada (merged) ao ramo principal (branch main), você pode excluir sua branch tranquilamente.**

</details>

<div align="center">

> ### **Que a força esteja com você.**
> 
> ### Desenvolvido por **Douglas Morais**

</div>
