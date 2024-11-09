import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"

export default function Page() {
  return (
    <main>
      <div className="container mx-auto py-8">
        <Card className="w-full max-w-4xl mx-auto">
          <CardHeader>
            <CardTitle className="text-3xl font-bold text-center">Termos de Uso - Celmouse</CardTitle>
          </CardHeader>
          <CardContent className="prose prose-sm max-w-none ">
            <ol className="list-decimal space-y-6 space-x-8">
              <li>
                <h2 className="text-xl font-semibold">Aceitação dos Termos</h2>
                <p>
                  Ao utilizar o aplicativo Celmouse {"(Aplicativo)"}, você concorda em cumprir estes Termos de Uso {("Termos")}. Se você não concordar com algum dos termos descritos, não utilize o Aplicativo.
                </p>
              </li>

              <li>
                <h2 className="text-xl font-semibold">Descrição do Serviço</h2>
                <p>
                  O Celmouse é um aplicativo que permite o controle de um cursor de mouse por meio de dispositivos móveis. O Aplicativo está disponível para diferentes tipos de usuários, incluindo um plano gratuito e um plano corporativo pago.
                </p>
              </li>

              <li>
                <h2 className="text-xl font-semibold">Elegibilidade</h2>
                <p>
                  Para utilizar o Celmouse, você deve ter pelo menos 18 anos de idade ou a permissão dos seus responsáveis legais. Ao criar uma conta, você garante que as informações fornecidas são precisas e atualizadas.
                </p>
              </li>

              <li>
                <h2 className="text-xl font-semibold">Planos de Assinatura</h2>
                <h3 className="text-lg font-medium mt-2">4.1 Plano Gratuito - Uso Pessoal e Não Comercial</h3>
                <p>
                  O plano gratuito do Celmouse está disponível exclusivamente para uso pessoal e não comercial. Ele é destinado a indivíduos que utilizam o aplicativo para fins não relacionados a negócios ou atividades comerciais. O uso do plano gratuito por empresas, organizações ou qualquer entidade comercial é estritamente proibido.
                </p>
                <p>
                  Corporations, empresas ou outras entidades comerciais devem adquirir uma licença corporativa apropriada. Qualquer violação deste termo resultará na suspensão ou encerramento da conta e na possível adoção de medidas legais.
                </p>
                <h3 className="text-lg font-medium mt-2">4.2 Plano Corporativo</h3>
                <p>
                  O plano corporativo oferece uma licença adequada para empresas, corporações e outras entidades comerciais. Este plano inclui funcionalidades exclusivas e suporte prioritário, conforme descrito em nossa página de preços. Para adquirir o plano corporativo, entre em contato com nossa equipe comercial.
                </p>
              </li>

              <li>
                <h2 className="text-xl font-semibold">Limitação de Responsabilidade</h2>
                <p>
                  O Celmouse é fornecido {'"como está"'}. Não garantimos que o aplicativo estará sempre disponível, livre de erros ou que atenderá a todos os requisitos dos usuários. Na máxima extensão permitida pela lei, o Celmouse e seus desenvolvedores não se responsabilizam por danos indiretos, incidentais ou consequenciais resultantes do uso do Aplicativo.
                </p>
              </li>

              <li>
                <h2 className="text-xl font-semibold">Uso Indevido do Aplicativo</h2>
                <p>
                  Você concorda em utilizar o Celmouse de acordo com a legislação aplicável e não irá usar o Aplicativo para atividades ilegais ou proibidas por estes Termos. Isso inclui, mas não se limita a, tentar obter acesso não autorizado ao serviço, realizar ataques cibernéticos ou distribuir conteúdo malicioso.
                </p>
              </li>

              <li>
                <h2 className="text-xl font-semibold">Modificações no Serviço</h2>
                <p>
                  Nós nos reservamos o direito de modificar, suspender ou descontinuar, temporariamente ou permanentemente, o Aplicativo ou qualquer parte dele, com ou sem aviso prévio. Não nos responsabilizamos por qualquer alteração ou descontinuação do serviço.
                </p>
              </li>

              <li>
                <h2 className="text-xl font-semibold">Suspensão e Encerramento de Conta</h2>
                <p>
                  Reservamo-nos o direito de suspender ou encerrar sua conta caso detectemos o uso indevido do Aplicativo, incluindo, mas não se limitando ao, uso do plano gratuito por corporações ou entidades comerciais sem a devida licença corporativa.
                </p>
              </li>

              <li>
                <h2 className="text-xl font-semibold">Propriedade Intelectual</h2>
                <p>
                  Todos os direitos sobre o Aplicativo, incluindo, sem limitação, o design, logotipos, e marcas, pertencem exclusivamente ao Celmouse. Nenhum direito ou licença é concedido ao usuário além do uso limitado do serviço conforme descrito nestes Termos.
                </p>
              </li>

              <li>
                <h2 className="text-xl font-semibold">Coleta e Uso de Dados</h2>
                <p>
                  O uso do Celmouse está sujeito à nossa Política de Privacidade, que descreve como coletamos, usamos, armazenamos e compartilhamos suas informações. Ao usar o Aplicativo, você concorda com os termos da nossa Política de Privacidade.
                </p>
              </li>

              <li>
                <h2 className="text-xl font-semibold">Alterações nos Termos de Uso</h2>
                <p>
                  Podemos revisar estes Termos de Uso a qualquer momento, sem aviso prévio. As alterações entrarão em vigor assim que forem publicadas no site ou no Aplicativo. O uso continuado do Celmouse após a modificação dos Termos implica a sua aceitação das novas condições.
                </p>
              </li>

              <li>
                <h2 className="text-xl font-semibold">Contato</h2>
                <p>
                  Se você tiver dúvidas sobre estes Termos, entre em contato conosco através do email: suporte@celmouse.com.
                </p>
              </li>
            </ol>
          </CardContent>
        </Card>
      </div>
    </main>
  )
}