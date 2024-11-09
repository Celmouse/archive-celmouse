import Image from "next/image"
import type { Metadata } from "next";
import localFont from "next/font/local";
import "./globals.css";
import { Analytics } from "@vercel/analytics/react"
import { GoogleAnalytics } from '@next/third-parties/google'


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
      <body
        className={`${geistSans.variable} ${geistMono.variable} antialiased`}
      >
        <div className="flex flex-col min-h-screen">
          <header className="px-4 lg:px-6 h-14 flex items-center">
            <a className="flex items-center justify-center" href="/">
              <Image width={32} height={32} src={"/logo.svg"} alt="Logo" />
              <span className="ml-2 text-2xl font-bold">Celmouse</span>
            </a>
            <nav className="ml-auto flex gap-4 sm:gap-6">
              <a className="text-sm font-medium hover:underline underline-offset-4" href="/downloads">
                Download
              </a>
              <a className="text-sm font-medium hover:underline underline-offset-4" href="#features">
                Features
              </a>
              <a className="text-sm font-medium hover:underline underline-offset-4" href="https://api.whatsapp.com/send?phone=5533997312898">
                Contact
              </a>
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
