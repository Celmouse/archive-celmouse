import Image from "next/image"
import type { Metadata } from "next";
import localFont from "next/font/local";
import "./globals.css";
import { Analytics } from "@vercel/analytics/react"
import { GoogleAnalytics } from '@next/third-parties/google'
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { Button } from "@/components/ui/button";
import { MenuIcon } from "lucide-react";
import Head from "next/head";
import Link from "next/link";

// Font files can be colocated inside of `app`
const myFont = localFont({
  src: './logo_font.otf',
  display: 'swap',

})


const geistSans = localFont({
  src: "./fonts/GeistVF.woff",
  variable: "--font-geist-sans",
  weight: "100 900",
});

const geistMono = localFont({
  src: "./fonts/GeistMonoVF.woff",
  variable: "--font-geist-mono",
  weight: "100 900",
});

export const metadata: Metadata = {
  title: "Celmouse",
  description: "You have all the control in your hands",
  openGraph: {
    title: 'Celmouse',
    description: 'You have all the control in your hands',
    url: 'https://celmouse.com',
    siteName: 'Celmouse',
    images: [
      {
        url: 'https://celmouse.com/opengraph-image.png',
        width: 1280,
        height: 1080,
      },
    ],
    locale: 'en_US',
    type: 'website',
  }
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <Head>
        <link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png" />
      </Head>
      <body
        className={myFont.className}
      >
        <div className="flex flex-col min-h-screen">
          <header className="px-4 lg:px-6 h-14 flex items-center justify-between">
            <Link href="/">
              <Image height={48} width={250}  src={"/named_logo.svg"} alt="Logo" />
              {/* <span className="text-3xl">Celmouse</span> */}
            </Link>
            <nav>
              <ul className="hidden md:flex ml-auto gap-4 sm:gap-6">
                <li>
                  <a className="text-sm font-medium hover:underline underline-offset-4" href="/downloads">
                    Download
                  </a>
                </li>
                <li>
                  <a className="text-sm font-medium hover:underline underline-offset-4" href="#features">
                    Features
                  </a>
                </li>
                <li>
                  <a className="text-sm font-medium hover:underline underline-offset-4" href="https://api.whatsapp.com/send?phone=5533997312898">
                    Contact
                  </a>
                </li>
              </ul>
              <DropdownMenu>
                <DropdownMenuTrigger asChild className="md:hidden">
                  <Button variant="outline" size="icon">
                    <MenuIcon className="h-[1.2rem] w-[1.2rem]" />
                    <span className="sr-only">Toggle menu</span>
                  </Button>
                </DropdownMenuTrigger>
                <DropdownMenuContent align="end">
                  <DropdownMenuItem>
                    <a href="/downloads">Download</a>
                  </DropdownMenuItem>
                  <DropdownMenuItem>
                    <a href="#features">Features</a>
                  </DropdownMenuItem>
                  <DropdownMenuItem>
                    <a href="https://api.whatsapp.com/send?phone=5533997312898">Contact</a>
                  </DropdownMenuItem>
                </DropdownMenuContent>
              </DropdownMenu>
            </nav>
          </header>

          {children}
          <footer className="flex flex-col gap-2 sm:flex-row py-6 w-full shrink-0 items-center px-4 md:px-6 border-t">
            <p className="text-xs text-gray-500 dark:text-gray-400">© 2024 Celmouse Ltda. All rights reserved.</p>
            <nav className="sm:ml-auto flex gap-4 sm:gap-6">
              <a className="text-xs hover:underline underline-offset-4" href="https://www.instagram.com/celmouseoficial/">
                Instagram
              </a>
              <a className="text-xs hover:underline underline-offset-4" href="/terms-of-use">
                Terms of Service
              </a>
              <a className="text-xs hover:underline underline-offset-4" href="/privacy">
                Privacy
              </a>
            </nav>
          </footer>
        </div>
      </body>
      <Analytics />
      <GoogleAnalytics gaId="AW-16600683276" />
    </html >
  );
}
