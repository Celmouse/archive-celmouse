'use client'
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { downloadUrls } from "@/lib/download-urls";
import Link from "next/link";

export default function Page() {
    return (
        <main>
            <div>
                <section id="download" className="w-full py-12 md:py-24 lg:py-32">
                    <div className="px-4 md:px-6">
                        <h2 className="text-3xl font-bold tracking-tighter sm:text-5xl text-center mb-12">Download Celmouse</h2>
                        <Tabs defaultValue='mobile' className="w-full max-w-2xl mx-auto">
                            <TabsList className="grid w-full grid-cols-4">
                                <TabsTrigger value="windows">Windows {"(BETA)"}</TabsTrigger>
                                <TabsTrigger value="mac">MacOSX</TabsTrigger>
                                <TabsTrigger value="linux">Linux</TabsTrigger>
                                <TabsTrigger value="mobile">Mobile</TabsTrigger>
                            </TabsList>
                            <TabsContent value="windows" className="mt-6">
                                <Card>
                                    <CardHeader>
                                        <CardTitle>Windows Download {"(BETA)"}</CardTitle>
                                        <CardDescription>WARNING: Download Celmouse for Windows. Currently on BETA and is being tested. Please use with caution!</CardDescription>
                                    </CardHeader>
                                    <CardContent className="flex justify-center">
                                        <Button asChild><Link href={downloadUrls.win}>Download for Windows</Link></Button>
                                    </CardContent>
                                </Card>
                            </TabsContent>
                            <TabsContent value="mac" className="mt-6">
                                <Card>
                                    <CardHeader>
                                        <CardTitle>Apple MacOS Download</CardTitle>
                                        <CardDescription>Download Celmouse for Mac</CardDescription>
                                    </CardHeader>
                                    <CardContent className="flex justify-center">
                                        <Button asChild><Link href={downloadUrls.macOS}>Download for Apple</Link></Button>
                                    </CardContent>
                                </Card>
                            </TabsContent>
                            <TabsContent value="linux" className="mt-6">
                                <Card>
                                    <CardHeader>
                                        <CardTitle>Linux Download</CardTitle>
                                        <CardDescription>Download Celmouse for Linux</CardDescription>
                                    </CardHeader>
                                    <CardContent className="flex justify-center">
                                        <Button asChild disabled={true}><Link href={downloadUrls.linux}>Download for Linux</Link></Button>
                                    </CardContent>
                                </Card>
                            </TabsContent>
                            <TabsContent value="mobile" className="mt-6">
                                <Card>
                                    <CardHeader>
                                        <CardTitle>iOS and Android Download</CardTitle>
                                        <CardDescription>Download Celmouse for Android or iOS</CardDescription>
                                    </CardHeader>
                                    <CardContent className="flex justify-center space-x-4">
                                        <Button asChild><Link href={downloadUrls.android}>Download for Android</Link></Button>
                                        <Button asChild><Link href={downloadUrls.ios}>Download for iOS</Link></Button>
                                    </CardContent>
                                </Card>
                            </TabsContent>
                        </Tabs>
                    </div>
                </section>
            </div>
        </main>
    );
}