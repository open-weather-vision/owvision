// @ts-check
import { defineConfig } from "astro/config";
import starlight from "@astrojs/starlight";

// https://astro.build/config
export default defineConfig({
    site: "https://open-weather-vision.github.io",
    base: "owvision",
    integrations: [
        starlight({
            title: "owvision",
            social: [
                {
                    icon: "github",
                    label: "Github",
                    href: "https://github.com/open-weather-vision/owvision",
                },
            ],
            customCss: ["./src/custom.css"],
            sidebar: [
                {
                    label: "User Guides",
                    autogenerate: { directory: "user-guides" },
                },
                {
                    label: "Developer Guides",
                    autogenerate: { directory: "developer-guides" },
                },
                {
                    label: "Plugins",
                    autogenerate: { directory: "plugins" },
                },
                {
                    label: "Reference",
                    autogenerate: { directory: "reference" },
                },
            ],
        }),
    ],
});
