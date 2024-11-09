import { Button } from "@/components/ui/button"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Mouse, PresentationIcon, Gamepad2, Keyboard, SquarePlus, Speech } from "lucide-react"
import Link from "next/link"
import { DownloadButton } from "./(components)/download-button"

export default function Page() {

  const features = [
    { title: "Gyroscope Control", description: "Control your mouse with precision using your phone's gyroscope.", icon: <Mouse className="w-8 h-8" />, },
    { title: "Presentation Mode", description: "Navigate through slides and midia effortlessly during presentations.", icon: <PresentationIcon className="w-8 h-8" />, },
    { title: "Gaming Enhancement", description: "Enhance your gaming experience with intuitive motion controls.", icon: <Gamepad2 className="w-8 h-8" />, },
    { title: "Keyboard", description: "Control your keyboard by typing on your phone.", icon: <Keyboard className="w-8 h-8" />, },
    { title: "Hotkeys", description: "Easy acess hotkeys to improve performance at work.", icon: <SquarePlus className="w-8 h-8" />, },
    { title: "Speech to text", description: "Speak instead of type.", icon: <Speech className="w-8 h-8" />, },

  ].map(feat =>
    <Card key={feat.title} className="text-center">
      <CardHeader className="flex items-center">
        {feat.icon}
        <CardTitle>{feat.title}</CardTitle>
      </CardHeader>
      <CardContent>
        <p>{feat.description}</p>
      </CardContent>
    </Card>
  );

  return (
    <main>
      <section className="w-full py-12 md:py-24 lg:py-32 xl:py-48">
        <div className="px-4 md:px-6 flex flex-col items-center space-y-4 text-center">
          <div className="space-y-2">
            <h1 className="text-3xl font-bold tracking-tighter sm:text-4xl md:text-5xl lg:text-6xl/none">
              Control Your Mouse with Your Phone
            </h1>
            <div className="mx-auto max-w-[700px] text-gray-500 md:text-xl dark:text-gray-400">
              <p>Use your phone&apos;s gyroscope to control your computer&apos;s mouse.</p>
              <p>Perfect for presentations, gaming, and more.</p>
            </div>
          </div>
          <div className="space-x-4 flex items-center" >
            <DownloadButton />
            <Button variant="outline"><Link href="#features" >Learn More</Link></Button>
          </div>
        </div>
      </section>
      <section id="features" className="w-full flex justify-center py-12 md:py-24 lg:py-32 bg-gray-100 dark:bg-gray-800 text-center">
        <div className=" px-4 md:px-6">
          <h2 className="text-3xl font-bold tracking-tighter sm:text-5xl mb-12">Features</h2>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8 items-center">
            {features}
          </div>
        </div>
      </section>
    </main>
  )
}