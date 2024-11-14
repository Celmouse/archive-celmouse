'use client'
import { downloadUrls } from '@/lib/download-urls';
import { useEffect, useState } from 'react';

import Link from 'next/link';
import { Button } from '@/components/ui/button';

export function DownloadButton() {
    const [os, setOs] = useState('');

    useEffect(() => {
        const userAgent = window.navigator.userAgent;
        if (/Windows/i.test(userAgent)) {
            setOs('Windows');
        } else if (/Mac/i.test(userAgent)) {
            setOs('Mac');
        } else if (/Linux/i.test(userAgent)) {
            setOs('Linux');
        } else if (/Android/i.test(userAgent)) {
            setOs('Android');
        } else if (/iPhone|iPad|iPod/i.test(userAgent)) {
            setOs('iOS');
        } else {
            setOs('Outro');
        }
    }, []);



    return (
        <div>
            {os === 'Windows' && <Button asChild><Link href={downloadUrls.win}>Download for {os}</Link></Button>}
            {os === 'Mac' &&
                <div className="flex flex-col space-y-4">
                    <Button asChild><Link href={downloadUrls.macOS}>Download for {os}OS Intel Chip</Link>
                    </Button><Button asChild><Link href={downloadUrls.macOSm1}>Download for {os}OS Sillicon Chip</Link></Button>
                </div>}
            {os === 'Linux' && <Button asChild disabled><Link href={downloadUrls.linux}>Download for {os}</Link></Button>}
            {os === 'Android' && <Button asChild><Link href={downloadUrls.android}>Download for {os}</Link></Button>}
            {os === 'iOS' && <Button asChild><Link href={downloadUrls.ios}>Download for {os}</Link></Button>}
            {os === 'Outro' && <Button asChild><Link href="/downloads">Download</Link></Button>}
        </div>
    );
}