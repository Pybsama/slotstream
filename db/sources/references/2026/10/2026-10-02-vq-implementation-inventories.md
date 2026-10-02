---
type: reference
id: 01m3z4vb981ta9nfcpx4g2xvnc
created: 2026-10-02T20:28:18.600626+00:00
updated: 2026-10-02T20:28:19.249436+00:00
summary: Complete bounded header inventories for pinned VQ 2.1, 3.2 and 4.4 candidate revisions.
captured_at: 2026-10-02T20:28:18.596393+00:00
title: Pinned VQ inventories for the quantization implementation screen
url: https://huggingface.co/TheDrainFlorist/Qwen3.8-Flash-Next-VQ-2.1bpw/tree/8684640a3956b01c47f5d47f9b999e2ab8b985f1
---
# Immutable VQ artifact inventories

Exact metadata and bounded HTTP header reads. No full weights or remote model code were executed. Tensor byte totals are storage geometry, not measured process footprints.

## VQ 2.1

```json
{
  "affine_default": {
    "bits": 8,
    "group_size": 32,
    "mode": "affine"
  },
  "affine_overrides": [
    {
      "bits": 8,
      "group_size": 64,
      "modules": 726
    }
  ],
  "expert_record_bytes_by_layer": {
    "0": 2611200,
    "1": 2611200,
    "10": 1280000,
    "11": 1280000,
    "12": 1280000,
    "13": 1280000,
    "14": 1280000,
    "15": 1280000,
    "16": 1280000,
    "17": 1280000,
    "18": 1280000,
    "19": 1280000,
    "2": 1280000,
    "20": 1280000,
    "21": 1280000,
    "22": 1280000,
    "23": 1280000,
    "24": 1280000,
    "25": 1280000,
    "26": 1280000,
    "27": 1382400,
    "28": 1382400,
    "29": 1382400,
    "3": 1280000,
    "30": 1382400,
    "31": 1382400,
    "32": 1382400,
    "33": 1382400,
    "34": 1280000,
    "35": 1382400,
    "36": 1280000,
    "37": 1280000,
    "38": 1280000,
    "39": 1280000,
    "4": 1280000,
    "40": 1280000,
    "41": 1280000,
    "42": 1280000,
    "43": 1280000,
    "44": 1280000,
    "45": 1280000,
    "46": 1280000,
    "47": 1382400,
    "5": 1280000,
    "6": 1280000,
    "7": 1280000,
    "8": 1280000,
    "9": 1280000
  },
  "expert_record_classes": {
    "1280000": 37,
    "1382400": 9,
    "2611200": 2
  },
  "expert_shared_codebook_bytes": 19535872,
  "families_bytes": {
    "experts": 33311823872,
    "ngram": 9600570368,
    "resident": 5318309400,
    "vision": 897862112
  },
  "files": {
    "README.md": {
      "bytes": 15773,
      "sha256": "d3bf42d868042f0a178cd87db6c705d6d7542868090e9e19f27c3ac87c2a8890"
    },
    "config.json": {
      "bytes": 182205,
      "sha256": "4299e87dc3b2d11e53c683d4f17f1196ccf95b75399ddd77d470e148aae1d929"
    },
    "model-00001.safetensors": {
      "file_bytes": 3502305102,
      "header_bytes": 12934,
      "header_sha256": "99906a7f92bf2cd9e71478581c05a69b86894c99a8c2d6c980d4fef915f80528"
    },
    "model-00012.safetensors": {
      "file_bytes": 4216376100,
      "header_bytes": 45540,
      "header_sha256": "bfd18ce5181df0df90b3bc44551768e9ea0720111b5cc4b8029fdb5b9a37d463"
    },
    "model-00013.safetensors": {
      "file_bytes": 4665462966,
      "header_bytes": 46638,
      "header_sha256": "0274d7a2fad35c55344552e511ce6c63f145afcbf783b195217215a8b3ac8428"
    },
    "model-00014.safetensors": {
      "file_bytes": 4716079037,
      "header_bytes": 53397,
      "header_sha256": "b2f9e7821d7dc9d98eb64bf33dc4e7a626c15661d069a461cf525bbf96a572c1"
    },
    "model-00015.safetensors": {
      "file_bytes": 4639508760,
      "header_bytes": 46736,
      "header_sha256": "30afe775c829246457d1f7cd6e3c4ffa184564e2a94fa8da025771ecca0d8764"
    },
    "model-00016.safetensors": {
      "file_bytes": 4969957797,
      "header_bytes": 46813,
      "header_sha256": "8da96df7941bc43ca1bd3b9cd31f8c4f73d2d48de6eca60eb097dfbaa1c00bf8"
    },
    "model-00017.safetensors": {
      "file_bytes": 4819896339,
      "header_bytes": 53483,
      "header_sha256": "bb76c703cede6ec7dd8f5b8e7eb7b5a16acdd3df64185817dc14e278079938f5"
    },
    "model-00018.safetensors": {
      "file_bytes": 4639508752,
      "header_bytes": 46728,
      "header_sha256": "39d940841ff4fbc0e82fba447a2361c303a22ca3a76617b03624414b8f0829e3"
    },
    "model-00019.safetensors": {
      "file_bytes": 2461411958,
      "header_bytes": 21198,
      "header_sha256": "df49047e423634f265d08a15d0eac8689cba346ce80875254a99ea94583aad22"
    },
    "model-ple-0000.safetensors": {
      "file_bytes": 75004893,
      "header_bytes": 429,
      "header_sha256": "f9f5a5304e0c688ee3e5b7ec027187df5c4bb4bb176adcb443f672400ba5e5b8"
    },
    "model-ple-0001.safetensors": {
      "file_bytes": 75004893,
      "header_bytes": 429,
      "header_sha256": "6881209d101497dc3c709fbba5fe3915ce2f05b53f08590335c3ab79b5cd1c51"
    },
    "model-ple-0002.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "3e0845b041867569571abff23cdf3bddf7bee6f24aad9af452ea048fbbebb4bb"
    },
    "model-ple-0003.safetensors": {
      "file_bytes": 75004899,
      "header_bytes": 435,
      "header_sha256": "1821295a2764e28c444520afeef2a1a9bc57bf68b13a7ee63f1647d26d8ec131"
    },
    "model-ple-0004.safetensors": {
      "file_bytes": 75004899,
      "header_bytes": 435,
      "header_sha256": "1b10b8d3c0cc4ed6035d136ac3d6f503bb2f4d070db13fcc51d8c9b29d7e10e2"
    },
    "model-ple-0005.safetensors": {
      "file_bytes": 75004899,
      "header_bytes": 435,
      "header_sha256": "ec97575e8629d8c633fd69b4cdbc7873384fcc5d17c644aebce85307f9fa07ac"
    },
    "model-ple-0006.safetensors": {
      "file_bytes": 75004899,
      "header_bytes": 435,
      "header_sha256": "16690819bcdd0013feeaa1dd0839e0a948c594f4c424ff387553d6bd7df6ce57"
    },
    "model-ple-0007.safetensors": {
      "file_bytes": 75004899,
      "header_bytes": 435,
      "header_sha256": "eebaae27289b8d706bfe8f6f81c55cae9ef929c0ac8d2b4bf3e4d52acffb9a4c"
    },
    "model-ple-0008.safetensors": {
      "file_bytes": 75004899,
      "header_bytes": 435,
      "header_sha256": "dedc259ef4da85137c925e60a9b4c0b641a6cf6fbd76ba855798279cf6e335e3"
    },
    "model-ple-0009.safetensors": {
      "file_bytes": 75004899,
      "header_bytes": 435,
      "header_sha256": "b97bf31f4a4916ccef0da2373822646058dc81bad97a0e6b3185b1f0f19f929e"
    },
    "model-ple-0010.safetensors": {
      "file_bytes": 75004899,
      "header_bytes": 435,
      "header_sha256": "6af6885c00c767353fd5b2d28ca98a636d1a2ed1b755d64b7ffa7e03bf5ec349"
    },
    "model-ple-0011.safetensors": {
      "file_bytes": 75004899,
      "header_bytes": 435,
      "header_sha256": "3043302965238c60d20e84616797eb18f7d90e430ddbbaa57ce50722b1dde6d7"
    },
    "model-ple-0012.safetensors": {
      "file_bytes": 75004899,
      "header_bytes": 435,
      "header_sha256": "3061859f457c53aa31c804f1b0a8fd926891d7e7bbd84676c86c62662a5819c9"
    },
    "model-ple-0013.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "ee6ba9a5c7d50af370c0bb48225fa54fe3af392600d6a55b0ac84fadd6f5dbf3"
    },
    "model-ple-0014.safetensors": {
      "file_bytes": 75004899,
      "header_bytes": 435,
      "header_sha256": "d21fa547c0abe1c0c463337bbf3f9ffa50c6904b824ea7678df1985a2ef51737"
    },
    "model-ple-0015.safetensors": {
      "file_bytes": 75004899,
      "header_bytes": 435,
      "header_sha256": "e574cc2aa206ca5fa356d6aae4a3a6b4ec8b1fc9c95e9917cfc200311ac92fa9"
    },
    "model-ple-0016.safetensors": {
      "file_bytes": 75004899,
      "header_bytes": 435,
      "header_sha256": "e4ff9bffc92eb20d18f91fa07277392a0efe43469e8e9cd5ee4087f437391029"
    },
    "model-ple-0017.safetensors": {
      "file_bytes": 75004899,
      "header_bytes": 435,
      "header_sha256": "fcb1699be3a8928c6ab812f188deff5d04c395be42042b467296f5b733e7a564"
    },
    "model-ple-0018.safetensors": {
      "file_bytes": 75004899,
      "header_bytes": 435,
      "header_sha256": "f0c768d511931d16f8defdb5c219da98ad970efd5f4b5364ad3c2b69c170b305"
    },
    "model-ple-0019.safetensors": {
      "file_bytes": 75004899,
      "header_bytes": 435,
      "header_sha256": "3152c6725bbfe0997833e53c1bd206ce1a96e0636a968da74a72a00e205d2906"
    },
    "model-ple-0020.safetensors": {
      "file_bytes": 75004899,
      "header_bytes": 435,
      "header_sha256": "42713f4ed33259d1999474b3b470f901781bf9fd985fffc49ba8367e7792b068"
    },
    "model-ple-0021.safetensors": {
      "file_bytes": 75004899,
      "header_bytes": 435,
      "header_sha256": "bba0270ad89f7d4e44fc1f90b338ea0a93501ec22ecbab4afd0060d2260973b3"
    },
    "model-ple-0022.safetensors": {
      "file_bytes": 75004899,
      "header_bytes": 435,
      "header_sha256": "cc4ff645d60ebb7677deec985eb5ad055a11f3914094f22d356d3faa0472aaf9"
    },
    "model-ple-0023.safetensors": {
      "file_bytes": 75004899,
      "header_bytes": 435,
      "header_sha256": "73ed1d8966f30def64b5ca9750f750775f6a3dda40d2f498db22c00ff9644b90"
    },
    "model-ple-0024.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "62834d77831023da85ad2986189f0efddd4ab503c1a158fcb41f1ce6bb253f3e"
    },
    "model-ple-0025.safetensors": {
      "file_bytes": 75004899,
      "header_bytes": 435,
      "header_sha256": "901d84d21e60187eaad354ede26805042ac2123de13c3ae67065670705cec573"
    },
    "model-ple-0026.safetensors": {
      "file_bytes": 75004899,
      "header_bytes": 435,
      "header_sha256": "4b05d3a6522dab3f6a37908b24c07cbf158e2209c582faae16a6f178392c3369"
    },
    "model-ple-0027.safetensors": {
      "file_bytes": 75004899,
      "header_bytes": 435,
      "header_sha256": "94b112d7b56805dc0abca6e8709164d925e501cd1236c3f95bbd2395979cc0fd"
    },
    "model-ple-0028.safetensors": {
      "file_bytes": 75004899,
      "header_bytes": 435,
      "header_sha256": "8e032f80d5bf24e3b4278999299ed499c7d062a338a5d1532cf0cdda32c272cb"
    },
    "model-ple-0029.safetensors": {
      "file_bytes": 75004899,
      "header_bytes": 435,
      "header_sha256": "1676ac77e7dd688828c2ab0072c3651ea9a2482a383b8e419ba6ce2f715bf918"
    },
    "model-ple-0030.safetensors": {
      "file_bytes": 75004899,
      "header_bytes": 435,
      "header_sha256": "aeee2e191dab7476802b7d6c7d7d9cea0ff05b04eec40346910e39653aa69843"
    },
    "model-ple-0031.safetensors": {
      "file_bytes": 75004899,
      "header_bytes": 435,
      "header_sha256": "d4cb2575dac8d717c7411f88db3d02c3b142b66fde865c7395dbe7d55ffe76c6"
    },
    "model-ple-0032.safetensors": {
      "file_bytes": 75004899,
      "header_bytes": 435,
      "header_sha256": "e7cc85263c28e758829988b21786b9382722b43771681dcebfec641b56185fbd"
    },
    "model-ple-0033.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "4748f3230c6f456283f830625e24fdf36439521d8e0ce0f880fe8c6f714ff54e"
    },
    "model-ple-0034.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "547501155b1d1e101e0980c2dd6eae09456eefe14b2a294f9c62da0fa4d9d913"
    },
    "model-ple-0035.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "e6d551eed9baf5a7ea11ceb261d859fa8b5e04510eca7d169e8126947a13e063"
    },
    "model-ple-0036.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "098f72599b6582acadae5ff0a22727288db5135c3c09544dec589f16514d0458"
    },
    "model-ple-0037.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "34abaef865ff1645647de4371c251a09a9a268cf2adbd79cbff2bf7da1e2ae52"
    },
    "model-ple-0038.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "b365a95da87a4559b9087366fdab5151c7e36e93b5564c5a8c4d3627ad9252ad"
    },
    "model-ple-0039.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "b1dbd6a188f48ff513d965a3accbc0c4721cfe96bc652f820a6ce8dd8914cee7"
    },
    "model-ple-0040.safetensors": {
      "file_bytes": 75004893,
      "header_bytes": 429,
      "header_sha256": "068b0703431c6ee86088949e5554b4e2a7dd46b198580a5459e19ce0d1251f56"
    },
    "model-ple-0041.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "264208607f1ec5b9847ba7cc778a52587fede36f70f1eca0d20456adec001cba"
    },
    "model-ple-0042.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "4910d88c25c43214e8ccafaf67ff273f1adcf78ffb0a6c58a13d5debbf6e9f39"
    },
    "model-ple-0043.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "0e039659afe9e074a50a8254364f8017753a76e9c284296cd81ab6ccfdc79895"
    },
    "model-ple-0044.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "8170744825fd19a247fdbf058e7f5cbbe9b93708322ca51dd9bd72f9f2220c5a"
    },
    "model-ple-0045.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "0ecb42ecd37fc8e2c0dd08a593c83cde6057683ca1f19cf0a69f5cd697c58ec9"
    },
    "model-ple-0046.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "20d058cb2275baf41961145a587d8c0ec83198c5a67c3a7bec441b6f9bb18130"
    },
    "model-ple-0047.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "ddafd67a591c0fc452e28e7bd15e437c3694c33d7a2f81e338f85f4f8a9ae5dd"
    },
    "model-ple-0048.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "eefa382c2a4b2c386a52cddfc27186ecf4be3a2be770384027ab59a8b1149370"
    },
    "model-ple-0049.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "5634fcd68a552c29c2fa2875b7ce903145e8804ead20252971e1b8727b3f378d"
    },
    "model-ple-0050.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "3619189464ee22a22ebce5b5c96bd16b19dadc53d90743e14bbad4da70fa4233"
    },
    "model-ple-0051.safetensors": {
      "file_bytes": 75004893,
      "header_bytes": 429,
      "header_sha256": "d593cfd4d22e73dda17e12f6eb8a9d352cfcae7e7623d2b5ca0fdc5e6e8a9bd9"
    },
    "model-ple-0052.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "573fced2f015cfd62040cdeadb058607706822906f256c5cf7f5b9f12aa2f41d"
    },
    "model-ple-0053.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "4eae8c3f89973e76ec7693aa10e11e112d7576e726a4102163cc21c7ea480803"
    },
    "model-ple-0054.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "956592e6ab5002075a3e11998e83a054b8e84c43b2b07fc4d4ae81452577932e"
    },
    "model-ple-0055.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "f8d346eb92c8acb4eee53c6295e0d06a8c69562911d4d9a5a7c00b1a023158b0"
    },
    "model-ple-0056.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "513fa0f760e04230ba6dcba27aef27f02aed47958a39abcde89ef5c703a25c37"
    },
    "model-ple-0057.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "2a77a8538abcaf618e39f62ca61077093649f11d8f27b075b59d6302a53c466d"
    },
    "model-ple-0058.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "8ad3d1dff6765133a6603811afab797afc479ba8e1368b1d99ba59f4567052c9"
    },
    "model-ple-0059.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "be85a34f830452423b0526e329a9eac113477d9dcfe7e3aaf915d072ff6ad5e2"
    },
    "model-ple-0060.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "4f8724a7f443b2b080e9617f341a266941bfdb56259ba0adf11a6cce23fa03a7"
    },
    "model-ple-0061.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "b0d27cf7e07caa6ba902555ad22d8149f0cf92b4d4b59bc6c70c6e218a0771df"
    },
    "model-ple-0062.safetensors": {
      "file_bytes": 75004893,
      "header_bytes": 429,
      "header_sha256": "9bd0a57348ceb4dfd6863c4769e6a902725c90a0b71fce6852f5c428fedb0687"
    },
    "model-ple-0063.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "c3289a891a87c3720813a9ef5f5b13449008c76f9824a0c7b96cea851cdde28e"
    },
    "model-ple-0064.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "157c3de82c31e96488eae224e9c3a3b03b19232864257a1bd1e05acc61902cb5"
    },
    "model-ple-0065.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "6c1804405fe9549b3b7acfe10c54db1a21596caad44959f948da97dd693ad2e4"
    },
    "model-ple-0066.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "ac5a750f039af2841a624f060669ce667f12834014725bbb897a4983ebf9232f"
    },
    "model-ple-0067.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "26efae511a5f88894bdc600182273542d59956a0c074f15b39ca8339edec0130"
    },
    "model-ple-0068.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "2bbf7de2da390244582ff19882c4edc2edfa1f17a2c4e91007fbdd0d76a5dcdb"
    },
    "model-ple-0069.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "67108f4178afe5deb312e54ea024873bab22d21da184921febe0d85abd9a4055"
    },
    "model-ple-0070.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "61bb1bd6375bc5bba5f7d1199ba8a0868bab98b19ecbde49aed0b06b26928921"
    },
    "model-ple-0071.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "4b76d4c7a5ff59c12bb99073d8099be028e1f714961e23a19daf67bc4f41dd5f"
    },
    "model-ple-0072.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "38504063160c2a8296a1754b561e5fd7ae267cafb7bbad697f61d119272b92b0"
    },
    "model-ple-0073.safetensors": {
      "file_bytes": 75004893,
      "header_bytes": 429,
      "header_sha256": "c53e7a42aafa21cda6faab45bf6ef61f3113abf870c43fdeff257b40b67e191c"
    },
    "model-ple-0074.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "634d09bbfe0042abca3a3e56b7998c8fe3fdcbdd1ce39556272287587f00feb0"
    },
    "model-ple-0075.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "b3d9e2885084063e4893ad9241ca8792a0887a2d3b56adc298fd48fe409b1d1c"
    },
    "model-ple-0076.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "c5c180bc6975775d84c209416a273ccfcc3d19eb37a7937e3a54b31459141511"
    },
    "model-ple-0077.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "89aa55c15adea1e034cd14eec698c687af80d2e29444db5b65c88807d7cabf4b"
    },
    "model-ple-0078.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "f64554de31ba7d0fc78fb2f0bbd97be0c4a0c66b69381f178e06deb863fc6312"
    },
    "model-ple-0079.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "5936fa2b963cc1050f178a1a2b164b34f0b3fd63bcfdea8ae15bae2b8dc76639"
    },
    "model-ple-0080.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "7d7ea8ab19bf01f05eadc3c74c62c3b5a0f4bbc6bf2733d1fe9e015e404940ef"
    },
    "model-ple-0081.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "cc3106de5b62518e8d92374ce49cf5c8b54aff39f9c34517ded5a9bc62b5b942"
    },
    "model-ple-0082.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "0fe49cf6b1a2bb46dea76fd6a0900ab4f830acb94a86a6ead12a242eea716139"
    },
    "model-ple-0083.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "96f52e87a92656734c7be784f5711e571744962665367cd44a798c07aa790de6"
    },
    "model-ple-0084.safetensors": {
      "file_bytes": 75004893,
      "header_bytes": 429,
      "header_sha256": "f25215cd744c0f5421db191f55aba7e5a6b33d19a081360b5058d78b7f6652ae"
    },
    "model-ple-0085.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "fb1986a8a7e7c985f50af40939675b7ad226ae8de318b3fabd762bd8054200a0"
    },
    "model-ple-0086.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "5347899532c802b0d40380ee2222125ee37f76181d6a000f8047dbe5d9c2e09a"
    },
    "model-ple-0087.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "9f337b82a2564695f69f22ccf91a8cdfcaf17909d95edb3eb9f74621d429f153"
    },
    "model-ple-0088.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "59387536dd932ca7c7cdf859f1d3d87830b3826943499ea1879230828339a321"
    },
    "model-ple-0089.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "06519280d655687241570497280b2687e2d577deb6ef585dab49ef5c89ae8e30"
    },
    "model-ple-0090.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "a246801140d00ca2192506f7a70e18f56f57fb34b52f5d2cdbdbf53db8d1dc7b"
    },
    "model-ple-0091.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "8546c280b5d2592ec9c42ccbf532fbcc2d5e1bc2c91447c2cab06cd1f6e3ac80"
    },
    "model-ple-0092.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "292dadc4e644490a2c457a957cc629cc6b2860804d34170fbb8c5d98b761ca25"
    },
    "model-ple-0093.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "c4800c5a9d2cd7cacaee2a4812c454d1e7ce006a5b945e787c7227270accdfb8"
    },
    "model-ple-0094.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "31402a65a7856c2b12f3d3153e051a71369d5f954ee25cabb02cc75ca0585060"
    },
    "model-ple-0095.safetensors": {
      "file_bytes": 75004893,
      "header_bytes": 429,
      "header_sha256": "c30a0fadf81a0438b212cd0d136767b325bdf76db9617546d2bcebc736d00c57"
    },
    "model-ple-0096.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "b06332bc0de7e7d1dfd7a24ba60c4bf7b6cda2e60eb1688f8cf49f7de38dbebf"
    },
    "model-ple-0097.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "76e08fedfe1a82a39251eb15e24f89459e72248958fc53107d7404c2be0eac12"
    },
    "model-ple-0098.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "20967dc61b7066161abfb53675541247a3603f5a5ed325ce10d76ff6334c8155"
    },
    "model-ple-0099.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "7ede34ebccfe9bc63dd8f7fee52df4378a3ff5a9a34c23bc941cc5575b1d3179"
    },
    "model-ple-0100.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "6f2e4df9a100947b424468a4d9b8cce1f38fca52395c97a6ec071dc36dfd42a5"
    },
    "model-ple-0101.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "43a080173d4f14d439934b6529d6c5c23ed29605d96fd57e6c70309ce3a0b20d"
    },
    "model-ple-0102.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "5b5e4a96aad7e16c5e9dcaf06e72a58ace47c4c48c8d8fb3fedde12006088e44"
    },
    "model-ple-0103.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "d6882670d893347257b93b8dc71540ab09c8c6fa30c00e3991bce4ae77ad90c0"
    },
    "model-ple-0104.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "ba51288d59e5de9251f8a171aafd7f17e7211758799e5031dfc60051f7063622"
    },
    "model-ple-0105.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "7f31fa849888f57827d7e68d1d4a6260e8e5c8d9bc9d1804f9416fd078999b32"
    },
    "model-ple-0106.safetensors": {
      "file_bytes": 75004893,
      "header_bytes": 429,
      "header_sha256": "a7eeb2fb634fdb7c46f2d9450677224ac281ea766fd64fd633ce526cb1e3eca2"
    },
    "model-ple-0107.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "6e6daa92beb065a960c9a32101edb80ecbb92bb5f19b31f8fa602e86e0b00215"
    },
    "model-ple-0108.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "ca1af8aa6bf85a171247f4a3a19a5fbdd7ed4b44c594ec76cf5eda5e1156d1cc"
    },
    "model-ple-0109.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "ecd6c8296dde0585b4583d3dd50dbd5bf28d4fb8a769b51b49c131dd2b5dc07f"
    },
    "model-ple-0110.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "7b23efb5c2060a067e376c79fa096aa7af22725ef0663acc3c174b97b8010b4a"
    },
    "model-ple-0111.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "165a43eaa36241b0448824fccad264f236c179eb58eaf6ff2246d670be3a4a32"
    },
    "model-ple-0112.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "3eb6471754dfd90abc22a324ff9b9fad071128af3ce6158478a00c4431769e41"
    },
    "model-ple-0113.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "3e5226cb443e5cbfca4b3ab887e7047a952a177ac3217a6594d348b779003f89"
    },
    "model-ple-0114.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "a587260d6151c0e0188e60c29485fa890414125212e3fd11549632e3d071071a"
    },
    "model-ple-0115.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "afa408af932f8684ff2e07b9a992c28a32bec78c2f222b0e96c16cbcff5f0a85"
    },
    "model-ple-0116.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "1da1409b450f69ce46d0ee773406ca4d0d399aa4d12a0cbb4bbb9cd212871005"
    },
    "model-ple-0117.safetensors": {
      "file_bytes": 75004893,
      "header_bytes": 429,
      "header_sha256": "96f7d8655d477e9affa42aa0625ed80dc2e3071b881ea97d40361102774b820d"
    },
    "model-ple-0118.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "dda3ed103ea42adf4abda85b59d8efa6faa84e64ad7754148ad76df814729891"
    },
    "model-ple-0119.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "b3f031f7b2a436ee980153cfeb77036032dad4db295b5b23590555066cd91bd1"
    },
    "model-ple-0120.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "f80b20a320978a848fe06da28a58bf95ec4bae90f51a254f10486aa5845cdcb8"
    },
    "model-ple-0121.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "1de3bf33ff2a2775d93c5494632056bea70c740cf5396e13681a46d13414db95"
    },
    "model-ple-0122.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "ead46ee58eb555f08844aa9d64e085f456a0c139f974f6fcf43e756c78dce44c"
    },
    "model-ple-0123.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "2aff1acc0552d89a3a18bdabb232c19dbb347c15857815359f2ff28f90799c49"
    },
    "model-ple-0124.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "c8b5288b88f55ec2f831509a16d1c109283b46e6dd1cf8a5e5b14a4ba676944e"
    },
    "model-ple-0125.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "825858ccb104217b9dc899b041a7f8e3c321ca0ae42839acd5d20f5006be78eb"
    },
    "model-ple-0126.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "7e799a0d3d464ff148632015b74ee350034023680ef7d54278e1a3ce64561623"
    },
    "model-ple-0127.safetensors": {
      "file_bytes": 75004896,
      "header_bytes": 432,
      "header_sha256": "90e8a84b9c6aa50b21e5d19a434b81bd7d27d80047eab62aadb7abdb714975e4"
    },
    "model-vision-graft.safetensors": {
      "file_bytes": 897899165,
      "header_bytes": 37045,
      "header_sha256": "d8af3732673896e8db1e6b86c4de86aed9f2251773ef695cfe7ca1be2a1ce538"
    },
    "model.py": {
      "bytes": 226033,
      "sha256": "36de8d6ba21ff93ac3de2994eed4fd59e9cfab86b1908f72f5ee2673bd0aa5bb"
    },
    "model.safetensors.index.json": {
      "bytes": 319321,
      "sha256": "35f2f37dd0eda19f81cae8436d0c102c9e1ad13c4381bd8dea72a0d4a6ef25eb"
    }
  },
  "network_bytes": 1210298,
  "qualification": {
    "memory": "unproven",
    "quality": "unproven",
    "runtime": "unproven",
    "speed": "unproven"
  },
  "repo": "TheDrainFlorist/Qwen3.8-Flash-Next-VQ-2.1bpw",
  "revision": "8684640a3956b01c47f5d47f9b999e2ab8b985f1",
  "schema": 1,
  "tensor_count": 3671,
  "vq_ngram_geometry": {
    "dim": 8,
    "group": 32,
    "iters": 12,
    "k": 256,
    "row_bytes": 20,
    "sample": 2000000,
    "seed": 1234
  }
}
```

## VQ 3.2

```json
{
  "affine_default": {
    "bits": 8,
    "group_size": 32,
    "mode": "affine"
  },
  "affine_overrides": [
    {
      "bits": 8,
      "group_size": 64,
      "modules": 726
    }
  ],
  "expert_record_bytes_by_layer": {
    "0": 2611200,
    "1": 2611200,
    "10": 1843200,
    "11": 1843200,
    "12": 1843200,
    "13": 1843200,
    "14": 1843200,
    "15": 1843200,
    "16": 1843200,
    "17": 1843200,
    "18": 1843200,
    "19": 1843200,
    "2": 1843200,
    "20": 1843200,
    "21": 1843200,
    "22": 1843200,
    "23": 1843200,
    "24": 1843200,
    "25": 1843200,
    "26": 1843200,
    "27": 1843200,
    "28": 1843200,
    "29": 1843200,
    "3": 1843200,
    "30": 1843200,
    "31": 2611200,
    "32": 1843200,
    "33": 1843200,
    "34": 1843200,
    "35": 1843200,
    "36": 1843200,
    "37": 1843200,
    "38": 1843200,
    "39": 2611200,
    "4": 1843200,
    "40": 1843200,
    "41": 1843200,
    "42": 1843200,
    "43": 1843200,
    "44": 1843200,
    "45": 1843200,
    "46": 1843200,
    "47": 2611200,
    "5": 2611200,
    "6": 1843200,
    "7": 1843200,
    "8": 1843200,
    "9": 1843200
  },
  "expert_record_classes": {
    "1843200": 42,
    "2611200": 6
  },
  "expert_shared_codebook_bytes": 2082816,
  "families_bytes": {
    "experts": 47659862016,
    "ngram": 20802196992,
    "resident": 5318309400,
    "vision": 897862112
  },
  "files": {
    "README.md": {
      "bytes": 15036,
      "sha256": "176b1a717dd66da215c156c8238f8b65e4d9015b117d4bbd6d8565819a1fc1cf"
    },
    "config.json": {
      "bytes": 182008,
      "sha256": "75d7d9b1bfa7762e46ef7c512f6779b43fbd1a1a7f9715684a79f6b01f07cfe5"
    },
    "model-00001.safetensors": {
      "file_bytes": 3502305114,
      "header_bytes": 12946,
      "header_sha256": "d2bd4ff4778dd9ef9f52af5cb01c56da9cdbcc39d1391388269b883d8243f696"
    },
    "model-00012.safetensors": {
      "file_bytes": 6258175824,
      "header_bytes": 45584,
      "header_sha256": "cf7320656608c817b3a7e328649221782e71fbde96cd6bf2bd391cbad9814aad"
    },
    "model-00013.safetensors": {
      "file_bytes": 6471407889,
      "header_bytes": 46729,
      "header_sha256": "910b77d1fd04822afc1c80335001ca9426ecd92a73acafb81c79d20d2c79bc3a"
    },
    "model-00014.safetensors": {
      "file_bytes": 6547978262,
      "header_bytes": 53486,
      "header_sha256": "3f545c515cd11d3cdafdecbca4cd48ba0f00554caf7493b1da7a2771fa0b3fb0"
    },
    "model-00015.safetensors": {
      "file_bytes": 6471407935,
      "header_bytes": 46775,
      "header_sha256": "71c01c541ebc794ed72aa3291537594c1614dd780a34b528c454f4c2c622c649"
    },
    "model-00016.safetensors": {
      "file_bytes": 6857620951,
      "header_bytes": 46863,
      "header_sha256": "8d22810df17c9fef6d29f272eb0d12d2d9992e1ee49053ef9a8ba077b9c4dedf"
    },
    "model-00017.safetensors": {
      "file_bytes": 6679034951,
      "header_bytes": 53535,
      "header_sha256": "c37d7657eb55d30ca53ccbfef113fd08b89e83edb8b7289190e86686ed5de291"
    },
    "model-00018.safetensors": {
      "file_bytes": 6733521211,
      "header_bytes": 46771,
      "header_sha256": "2bcd287e9a69a5998748a7cc6f6dcd12fc5d18944cef90159758c3dd29c4dc2c"
    },
    "model-00019.safetensors": {
      "file_bytes": 3457093298,
      "header_bytes": 21258,
      "header_sha256": "1a10c72aedf4e071712b23650e51ba32aebe505b7228ddecb2869192e2cdf363"
    },
    "model-ple-0000.safetensors": {
      "file_bytes": 162517607,
      "header_bytes": 435,
      "header_sha256": "7d0d6e160b692c4ace03293d26b7e25d6b04d5c10e74266e053897b4917ada23"
    },
    "model-ple-0001.safetensors": {
      "file_bytes": 162517605,
      "header_bytes": 433,
      "header_sha256": "ec0eeeff7b0441a7a43f2c0c304744967a3043e6bbe4b0255e9e14b2128c662a"
    },
    "model-ple-0002.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "52106b9df3274016f2c3918d6a7fca79534811fcdda87b6462d516ac19232104"
    },
    "model-ple-0003.safetensors": {
      "file_bytes": 162517613,
      "header_bytes": 441,
      "header_sha256": "67468f5edcb5e9d727d26fb7903dc5837ea00ac07b79d16dbb019421fd1cb0d6"
    },
    "model-ple-0004.safetensors": {
      "file_bytes": 162517613,
      "header_bytes": 441,
      "header_sha256": "05f9f81069af457cc6495843d9e2adb8f9204edc055fc8e21c348517d6c4ff18"
    },
    "model-ple-0005.safetensors": {
      "file_bytes": 162517611,
      "header_bytes": 439,
      "header_sha256": "715a0a355074e5f090332ad961b5ec55b482b328319f593da82cf8906ec4d5a8"
    },
    "model-ple-0006.safetensors": {
      "file_bytes": 162517611,
      "header_bytes": 439,
      "header_sha256": "727d6bf47654e2c32bc1c578c500e28f5e87ae5ecf3f72cdd9d7e195a956ae5b"
    },
    "model-ple-0007.safetensors": {
      "file_bytes": 162517611,
      "header_bytes": 439,
      "header_sha256": "647da7b736bf81aac4c839720b476ab692c100de7eea9f4550301d6e6890b24c"
    },
    "model-ple-0008.safetensors": {
      "file_bytes": 162517613,
      "header_bytes": 441,
      "header_sha256": "d33e0b3ea4e133ea1a80d6d4c100d6b22a3c9023384161f2bdd290bde204dd9a"
    },
    "model-ple-0009.safetensors": {
      "file_bytes": 162517613,
      "header_bytes": 441,
      "header_sha256": "78fd843d77630b68c785d222d6c04a8c5b671d1c25aa2ae0af53a126e8e48d27"
    },
    "model-ple-0010.safetensors": {
      "file_bytes": 162517613,
      "header_bytes": 441,
      "header_sha256": "90ef3b52149faa7f78c690ed6c3e3736b4d24c17fd8fe88ddb2a50cae4848ab5"
    },
    "model-ple-0011.safetensors": {
      "file_bytes": 162517613,
      "header_bytes": 441,
      "header_sha256": "f12bea28c2068f2cd9aa17446537529c91a27e8741b7b12be62c417a71d859ce"
    },
    "model-ple-0012.safetensors": {
      "file_bytes": 162517613,
      "header_bytes": 441,
      "header_sha256": "760badee1084465635d9619d69ab10bcdb1ad384b8c99e89413d0cbc8b22ba0b"
    },
    "model-ple-0013.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "8270938b2394d7f3a1cb83bcffdb41a5efb2fc3f51b3865ceaf69ba5cc279f6e"
    },
    "model-ple-0014.safetensors": {
      "file_bytes": 162517613,
      "header_bytes": 441,
      "header_sha256": "b72b0ee9d4c7086b0dce1e7a35274d85f5fdf62903403d0b14cc8e5ba7fe516b"
    },
    "model-ple-0015.safetensors": {
      "file_bytes": 162517613,
      "header_bytes": 441,
      "header_sha256": "23c295e110bfabde33f4072ab05b7ccd716b77c401ebd2265371e001606dd62f"
    },
    "model-ple-0016.safetensors": {
      "file_bytes": 162517613,
      "header_bytes": 441,
      "header_sha256": "7495f0822eb40f6d71dc60f5a311dd469c8e2a0b0ba1b405b41e4afe057463f8"
    },
    "model-ple-0017.safetensors": {
      "file_bytes": 162517613,
      "header_bytes": 441,
      "header_sha256": "6934ca44cb1a93c8ec1486a43b7d0c5e09bd2c9b04b1562bf44d3d87ad141ab2"
    },
    "model-ple-0018.safetensors": {
      "file_bytes": 162517611,
      "header_bytes": 439,
      "header_sha256": "07c9ec91df4c3dad4a9c6c7eb23080e03ba455bf0708fb23a98f20fb25e0863a"
    },
    "model-ple-0019.safetensors": {
      "file_bytes": 162517613,
      "header_bytes": 441,
      "header_sha256": "b43fe9dd6cd1a1f8f515883cb4c1701c85669c5ab0a38dbf4726c4e63683a009"
    },
    "model-ple-0020.safetensors": {
      "file_bytes": 162517611,
      "header_bytes": 439,
      "header_sha256": "ef62690022b270ef604178ee13354f8360776995f6954e8fa0fdb5f0e789e8c2"
    },
    "model-ple-0021.safetensors": {
      "file_bytes": 162517611,
      "header_bytes": 439,
      "header_sha256": "abe724f82c5017df68547dfcbc3a94f28b29b5920658931f40eb90cd94b3611a"
    },
    "model-ple-0022.safetensors": {
      "file_bytes": 162517613,
      "header_bytes": 441,
      "header_sha256": "3f3516ab3b5a8944bde1cdac1dc94e28334b07f418abf317fbd8e058c001434b"
    },
    "model-ple-0023.safetensors": {
      "file_bytes": 162517613,
      "header_bytes": 441,
      "header_sha256": "f970e5d1087a3514ce844a1924fc6b37df79396fa2afb63345ab7b69f17120c4"
    },
    "model-ple-0024.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "7c202d742fd8216cb688fc859e553a353fce38d66eae32e954b1b2554290bd81"
    },
    "model-ple-0025.safetensors": {
      "file_bytes": 162517613,
      "header_bytes": 441,
      "header_sha256": "8923533f1ad61f21ea7d7d25f137a2062e30df394abdc2e4df38a7058070b6b6"
    },
    "model-ple-0026.safetensors": {
      "file_bytes": 162517611,
      "header_bytes": 439,
      "header_sha256": "32e4973ecbec0eca3f175a8c10cd103086a94b8be7d6e94354ae02ad85fba585"
    },
    "model-ple-0027.safetensors": {
      "file_bytes": 162517613,
      "header_bytes": 441,
      "header_sha256": "5d75cea5e4d5a0f10a21057b3288c41e8a4884798be875d460c8071cf9c632c9"
    },
    "model-ple-0028.safetensors": {
      "file_bytes": 162517611,
      "header_bytes": 439,
      "header_sha256": "6ed8e4d8f91de86f777d852733f2d58f03211bbe41c6685956ae10e88974edce"
    },
    "model-ple-0029.safetensors": {
      "file_bytes": 162517613,
      "header_bytes": 441,
      "header_sha256": "c2411ad07fd5fdde6d414641655878afd83a4caf71f5710e7e05207023db1d16"
    },
    "model-ple-0030.safetensors": {
      "file_bytes": 162517613,
      "header_bytes": 441,
      "header_sha256": "4e4a16ea42dcd550cb0b3483f0b27205caa26541771ee98e49f49fe93eacc01a"
    },
    "model-ple-0031.safetensors": {
      "file_bytes": 162517611,
      "header_bytes": 439,
      "header_sha256": "d458fd19911cceb2c3eec4824178d1f5aeeab50f4efe8371176dcdee4cbb79a0"
    },
    "model-ple-0032.safetensors": {
      "file_bytes": 162517613,
      "header_bytes": 441,
      "header_sha256": "91332859e68e000557d658e1f43cef7d4762e6a090b539dfae5a9de9b425495a"
    },
    "model-ple-0033.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "85ac70ce5e6e92ce23511683d67c149efb9b1d9b9218d1913c3280c14c33c8dc"
    },
    "model-ple-0034.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "4de4f8fd4544a44db0db53bd1b09ea53f0ba375661555b9a538fa2db0ad87869"
    },
    "model-ple-0035.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "b50cf1dda471554a1ef871f146d10aa28e36034b452c3b97ea1af7dfb1fbc97d"
    },
    "model-ple-0036.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "86db5950df96d6c66c234caa8d09040774a9cb02b7fe4d539fe2b38edd58ee79"
    },
    "model-ple-0037.safetensors": {
      "file_bytes": 162517608,
      "header_bytes": 436,
      "header_sha256": "90c22f8f53d8793df9467037c7439107b22928e0bc905af15b63e1e232461c5d"
    },
    "model-ple-0038.safetensors": {
      "file_bytes": 162517608,
      "header_bytes": 436,
      "header_sha256": "a2fe6174c484741542e39b3fc54a889076a880b98afe2a50925272b64d1ae391"
    },
    "model-ple-0039.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "606575012203d7449eec592fae1aa192354c5ce46f2e6c888e1a70e454b3adde"
    },
    "model-ple-0040.safetensors": {
      "file_bytes": 162517607,
      "header_bytes": 435,
      "header_sha256": "f72498490dabbbda71c1bdacb777c980c49fbfe5fe4b29aedaa9e730255f93c6"
    },
    "model-ple-0041.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "81b0a71ee3a045f6f308772041beb209628495c89a86a8880f4c920caf9bc1d8"
    },
    "model-ple-0042.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "6daf1e4a7b4b64ba1f23398b5f24f1c7a22ffa07c9e42f18a16928484ed5b7c0"
    },
    "model-ple-0043.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "e22d32b70ad8c88a09f5f7608ea7165b8ed74b39a416e4cb1ef35aacdce1d970"
    },
    "model-ple-0044.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "33be9e471811f72005cda131b7aa8cb08111fba7a30c85eafed75a7c94fd6b52"
    },
    "model-ple-0045.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "34c12c36734d530232a495bd0261097a397db1bfc8d0819d7eb77cd93e72922f"
    },
    "model-ple-0046.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "51808d41f4258aba3941974dd00e223b3f032560bf4d68c2fa18eb5212c2c8c8"
    },
    "model-ple-0047.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "dab4ea3510fa0bf86a264d299103e6843fc295ca1003447046197eba5602d0ef"
    },
    "model-ple-0048.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "f61279caef9de0235ab6fd2f91cc3ddf774293f0514589de5fcc21cf8edac652"
    },
    "model-ple-0049.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "c041121504f1a004e784cab904e45d4116b7a6ca373addfae0db5744cf378833"
    },
    "model-ple-0050.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "7478605942c0ff7567f9f54820b50096f6150cf9e82f3ee0b6781f2db06505c0"
    },
    "model-ple-0051.safetensors": {
      "file_bytes": 162517607,
      "header_bytes": 435,
      "header_sha256": "138fca7647066f303e8d0fd26a6d929ce8463d0d93c12319866d876e6c9c3cde"
    },
    "model-ple-0052.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "6ade060cb4bc0374a8106ca9ed078afc3d564ab4fb35a22b46a119b2d0e7798a"
    },
    "model-ple-0053.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "d750506f3f6e4d550a5622257adbeb67fc064e66a5b1bd1b65e16ce4ef0325f1"
    },
    "model-ple-0054.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "666cac16ff0898cdc48e8ca99d0785f9f8b121d84bbb481c523287f729120039"
    },
    "model-ple-0055.safetensors": {
      "file_bytes": 162517608,
      "header_bytes": 436,
      "header_sha256": "796313d3496b399c4fc7a9933065921a0da49b03b09598abb57c9f5498b568ee"
    },
    "model-ple-0056.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "a70976f7cc974cb1871e4a266c5811414e1cc3e0d653e9ec051380aab055c1db"
    },
    "model-ple-0057.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "3c59bda32e6010b5766b95503b59063562f180b9f358a91839a70160f9715b93"
    },
    "model-ple-0058.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "155411126867b72064e6771e826822af87b484e5324f3a4b5f59f6768e1af2b4"
    },
    "model-ple-0059.safetensors": {
      "file_bytes": 162517608,
      "header_bytes": 436,
      "header_sha256": "b0109cb3a02aa855d22521dfcd9a906902f5274d23c351680739ac39f69087e0"
    },
    "model-ple-0060.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "6e0b74a6b7d5f69969fcefb0d00a1cc89513b065a001200bdb9ceee5baf9f68a"
    },
    "model-ple-0061.safetensors": {
      "file_bytes": 162517608,
      "header_bytes": 436,
      "header_sha256": "94da07bedd9e9e519cdb5322a6726f61b6b0326a9b0f5d8ac16de5648696b48a"
    },
    "model-ple-0062.safetensors": {
      "file_bytes": 162517607,
      "header_bytes": 435,
      "header_sha256": "3c366d9db2cc991b0788dcc8fbe871838e8c31a92cd02de3d57b95fe9553f545"
    },
    "model-ple-0063.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "71d111c356a635b052fac7c8f53034c0dc12dc311ba3f868b5a7e5db97e30316"
    },
    "model-ple-0064.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "84d41532fd97bb2736326363501fb0f08f820dee4832c0a42bf77cbc87f68546"
    },
    "model-ple-0065.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "a57c4ee78bce73f8266866ff1636e2496174755e2191d7a9903701f82ec57009"
    },
    "model-ple-0066.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "7606661e0dc7ca4c572c7c2f3d66b3ea4d1e19ca5e55166fab172f191f4ddff4"
    },
    "model-ple-0067.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "2dd97efb887c01510d3698079cd67d276db60ab866ca17bf769ba3dec0cb83a7"
    },
    "model-ple-0068.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "7a7184f7df58799d62420b5f199cef5f81d891980cc51be6e51ab5029b7d1a58"
    },
    "model-ple-0069.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "3fa2703990244ed3b6d167d7b4a2df5ded7227d3f747f686ea5b6a4ad5477d90"
    },
    "model-ple-0070.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "c4a778edc2b391dcf222bcc771c79a2aee5b67b7c5dd61a4a13659497623ae73"
    },
    "model-ple-0071.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "9b011aafa3cacf2041cf919e87370159c9df513c7b4203f32973586b0209ccac"
    },
    "model-ple-0072.safetensors": {
      "file_bytes": 162517608,
      "header_bytes": 436,
      "header_sha256": "7e0284a91777e720e1d0dfa1333f84e5433503df1c6bc785b900b7aecfc34c14"
    },
    "model-ple-0073.safetensors": {
      "file_bytes": 162517607,
      "header_bytes": 435,
      "header_sha256": "50dca63b439ef9b5b79d495c4ab566a6a4a021e68b9e52f68d5836cd0185edea"
    },
    "model-ple-0074.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "f4978465042d8afb8ebb88b0b15e9993a839f70c5ceccbfdbe4ffa82cd26a287"
    },
    "model-ple-0075.safetensors": {
      "file_bytes": 162517608,
      "header_bytes": 436,
      "header_sha256": "90ac0679a7104a6d7d9c73d30be466f17dc813d48c0321e2e88ae4bf37cc3160"
    },
    "model-ple-0076.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "f73c8bbdf021ec5ee57491545f42c7775a9e20adbfbdb3f1d3e131899d6c278f"
    },
    "model-ple-0077.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "78fa00bebba69554feb36950423a3deb6b41998c0df9ac85ea2fa10fe533dfcd"
    },
    "model-ple-0078.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "33490e2dd69934b98e57bf6c463062e55a0e2a432aeb7e04cdc0b084b2119684"
    },
    "model-ple-0079.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "76e6bcc83a57e6bfbb4d1a6bd0595fae9e8012689aca3e0dab768fd6051d6537"
    },
    "model-ple-0080.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "2f0073bceef790cb32a3291c057daf3d14a5e620e78bb309dac24be0e95946aa"
    },
    "model-ple-0081.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "2fbb6b65b0ec81e84ac890d4d2e6a3b5271e9cba2f298e846493f1a5e542dee1"
    },
    "model-ple-0082.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "7595e566e940658933048baa0491e6eaa8efa43cbb19933dfec6d9fa88a51052"
    },
    "model-ple-0083.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "eaaf64a604e8bb2ed8b2633479e33e9a1dc09c5f9f4287c83c724a13a2cb608d"
    },
    "model-ple-0084.safetensors": {
      "file_bytes": 162517607,
      "header_bytes": 435,
      "header_sha256": "055899a434364469bfc2d01bf276833ce104253709f7cb722691456606400d1d"
    },
    "model-ple-0085.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "b6f0d3633c89ecda6e6e2c684ff2068d1c25231ec3a461acdb64029423dac4d9"
    },
    "model-ple-0086.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "1ce2efdef4e6c73a44cad945caacb88fe7009ecd77e7b091dd6905eebc1f3367"
    },
    "model-ple-0087.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "cad13d210c2c729e9f9825b228f4089fdd055262bd671991f15b09bfedf251db"
    },
    "model-ple-0088.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "2ed16a11b2f68d5fbde94d660406c600c001f7f4d132b6d943c25b7c17d35f62"
    },
    "model-ple-0089.safetensors": {
      "file_bytes": 162517608,
      "header_bytes": 436,
      "header_sha256": "3992b11bb1a3368a977c8d18d6272fbaec22035a86976199c15183c8b319abcb"
    },
    "model-ple-0090.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "3ac1a5fdcc16ec9f5374d5551a214322c7cf58e41157f59cae4e407ead4ab379"
    },
    "model-ple-0091.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "c4af0727ea967fbda9f6be774b56e4145d4e0d09ea27d893acc6e1f5ab698b41"
    },
    "model-ple-0092.safetensors": {
      "file_bytes": 162517608,
      "header_bytes": 436,
      "header_sha256": "e845e270a8517234e109111862e3f8eabc95f86b9c11b773499e226224521dd5"
    },
    "model-ple-0093.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "9a84809a5b7ba6963bfb451450747ba755f1134433132476155a9428f2dbf5a8"
    },
    "model-ple-0094.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "d1a1036dfd41637f94e76e44a0d3097dc634ab3f2f14c82b83d5c2d2a43fe183"
    },
    "model-ple-0095.safetensors": {
      "file_bytes": 162517607,
      "header_bytes": 435,
      "header_sha256": "1acf1cfd505dbf4d1598a1d97e6cd451478b1a57dba03b54c15a1508938d1b38"
    },
    "model-ple-0096.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "daf605e595c450723875d6f1e77f826792f1a28135b2202d12fdd279baac8d4e"
    },
    "model-ple-0097.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "82d3c526733d96e90890475ab02728eaef4aeb676ee25e57726622efc24aec31"
    },
    "model-ple-0098.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "0393af9e311b6650477484827e0b11954bbc98731f0f7f042c0774e9ee0b3f8b"
    },
    "model-ple-0099.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "7cdee36c5ddef55f4752b9dcbc915b1b0ab1b36e9c8d773e0b03f152eb86f44a"
    },
    "model-ple-0100.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "1a238c986cd3cba67aca827f562228861128dc1ad837ef7d8f0590fd98d9f5fa"
    },
    "model-ple-0101.safetensors": {
      "file_bytes": 162517608,
      "header_bytes": 436,
      "header_sha256": "bba65fae4e362241026f233ebe58622fd87c6471ef22aa5ab614ee48f1fdd350"
    },
    "model-ple-0102.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "c54ad28a0f10c383a2304375bd572723e66fa8d88af329d551aea338c40a4aca"
    },
    "model-ple-0103.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "89a82bb45e0100b61dddb513d99a8c98236f6bf6969952715be49e3adadd202c"
    },
    "model-ple-0104.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "cefe3650597777aa1104a36ccf65ebb96c8ceabda3e3ee790be23dbb41c58225"
    },
    "model-ple-0105.safetensors": {
      "file_bytes": 162517608,
      "header_bytes": 436,
      "header_sha256": "a38a8daaaeb42813de45eedf267bcde324c60bed31258a8b73055922cb8b4fa5"
    },
    "model-ple-0106.safetensors": {
      "file_bytes": 162517607,
      "header_bytes": 435,
      "header_sha256": "19c917105a8a08c40299ffbd3fa21e2a665a0bdffa67ae648b064a0133eef04b"
    },
    "model-ple-0107.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "b0380abb6135c7d6e84927fb2acb187f759f22bc56c1b11d795204753a52cf39"
    },
    "model-ple-0108.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "5fdfbb9705100f7b12cc205db106123294cc5c2dbea69daf8ec69e232bacced6"
    },
    "model-ple-0109.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "4a03331220a110727d51bd0b21c7d7448b1127aabe001b2d17961c802973c814"
    },
    "model-ple-0110.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "a79dd57438c325cf230253e7ee8574c6a7fec6bfe62d8e5c4cc55081b145462e"
    },
    "model-ple-0111.safetensors": {
      "file_bytes": 162517608,
      "header_bytes": 436,
      "header_sha256": "f4f68956763c465fef8d6157e33fe990bea786808bb50ba8da1c0433135bf163"
    },
    "model-ple-0112.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "31b2201c668533c68662b96f4a72485719e76edd56dfab3df4f291a50cefdfba"
    },
    "model-ple-0113.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "48af3eb8123ac59a27948943cd4497beb5d56556eae743f06eb07b86a036ec69"
    },
    "model-ple-0114.safetensors": {
      "file_bytes": 162517608,
      "header_bytes": 436,
      "header_sha256": "4a9b7f508f01f1dddd52a4adc839e6299db0ab3fbeed03ab549c3b30891c5a6f"
    },
    "model-ple-0115.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "d09b435e7abb9cb8a2e92b3b5483eeb22d7a0be357ada75b0b81468bf6ce3445"
    },
    "model-ple-0116.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "a86d506a21e70172f9547080a8856c33c6721b634baf388cbc803d48a0c539e5"
    },
    "model-ple-0117.safetensors": {
      "file_bytes": 162517607,
      "header_bytes": 435,
      "header_sha256": "f2fbcbacdacb2697f7f2aab4a7f68cbaf5c7751d51bc85e8dc082fdc7b5b07f5"
    },
    "model-ple-0118.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "a3ac2354f79ba1e1eca1b87f9b4b50cb88080f1a69b7dd17935925f8f8f61114"
    },
    "model-ple-0119.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "407f13f74a097f73119570042fae0998c8b7165272f2325d084c824a4184087a"
    },
    "model-ple-0120.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "0081b425dd1db2add18a31b66d980eebcc73346193f2a4e83df865372530974b"
    },
    "model-ple-0121.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "7b2d60ed4fc1f737e8cfaec282947d49a6413f68357c8b78a0a15580587bd3db"
    },
    "model-ple-0122.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "723b2fb691a5172712bd25b966761d4523ae5a8845f1525cd4fe25e8458af6d5"
    },
    "model-ple-0123.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "9ff9eba46f4f91899903ffb38a22993d546d1c4a883a7c6f5a2dd19904b3f918"
    },
    "model-ple-0124.safetensors": {
      "file_bytes": 162517608,
      "header_bytes": 436,
      "header_sha256": "a06c0caced31286cd4e9deaa53a81295773f0df51f97f4cdf8cce1610a5b3934"
    },
    "model-ple-0125.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "9553d9f5018b61cbd986110f51824dbea770edf0c0ab5375faffd6974cfb8446"
    },
    "model-ple-0126.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "3a38467822aacfa00cb414ca3db1a0fded5e7290a2db2f793afdd2d3b0f85239"
    },
    "model-ple-0127.safetensors": {
      "file_bytes": 162517610,
      "header_bytes": 438,
      "header_sha256": "22e497094d819166016a404030f157c62691859015add77aa46a56ea804c4399"
    },
    "model-vision-graft.safetensors": {
      "file_bytes": 897899165,
      "header_bytes": 37045,
      "header_sha256": "d8af3732673896e8db1e6b86c4de86aed9f2251773ef695cfe7ca1be2a1ce538"
    },
    "model.py": {
      "bytes": 262311,
      "sha256": "1685ec90feb24e421c379ae4e3594f659478905d2c1393617990d84d3f514ee8"
    },
    "model.safetensors.index.json": {
      "bytes": 319321,
      "sha256": "781f7c8cbd7bb093d918f2cff920453ceb6d0f57bc26c7968059bfaa9f0a399e"
    }
  },
  "network_bytes": 1246842,
  "qualification": {
    "memory": "unproven",
    "quality": "unproven",
    "runtime": "unproven",
    "speed": "unproven"
  },
  "repo": "TheDrainFlorist/Qwen3.8-Flash-Next-VQ-3.2bpw",
  "revision": "a4e1b44631619ba440d985e324d95dd106536a3d",
  "schema": 1,
  "tensor_count": 3671,
  "vq_ngram_geometry": {
    "dim": 4,
    "group": 32,
    "iters": 12,
    "k": 2048,
    "row_bytes": 55,
    "sample": 2000000,
    "seed": 1234
  }
}
```

## VQ 4.4

```json
{
  "affine_default": {
    "bits": 8,
    "group_size": 32,
    "mode": "affine"
  },
  "affine_overrides": [
    {
      "bits": 8,
      "group_size": 64,
      "modules": 726
    }
  ],
  "expert_record_bytes_by_layer": {
    "0": 3225600,
    "1": 3225600,
    "10": 2611200,
    "11": 2611200,
    "12": 2611200,
    "13": 2611200,
    "14": 2611200,
    "15": 2611200,
    "16": 3225600,
    "17": 2611200,
    "18": 2611200,
    "19": 2611200,
    "2": 3225600,
    "20": 2611200,
    "21": 2611200,
    "22": 2611200,
    "23": 2611200,
    "24": 3225600,
    "25": 2611200,
    "26": 2611200,
    "27": 2611200,
    "28": 2611200,
    "29": 2611200,
    "3": 2611200,
    "30": 2611200,
    "31": 3225600,
    "32": 2611200,
    "33": 2611200,
    "34": 2611200,
    "35": 2611200,
    "36": 2611200,
    "37": 2611200,
    "38": 2611200,
    "39": 3225600,
    "4": 2611200,
    "40": 2611200,
    "41": 2611200,
    "42": 2611200,
    "43": 2611200,
    "44": 2611200,
    "45": 2611200,
    "46": 2611200,
    "47": 2611200,
    "5": 2611200,
    "6": 2611200,
    "7": 2611200,
    "8": 2611200,
    "9": 2611200
  },
  "expert_record_classes": {
    "2611200": 41,
    "3225600": 7
  },
  "expert_shared_codebook_bytes": 211968,
  "families_bytes": {
    "experts": 66375072768,
    "ngram": 28800269312,
    "resident": 5318309400,
    "vision": 897862112
  },
  "files": {
    "README.md": {
      "bytes": 15722,
      "sha256": "ea1d8a48bfb1f51f1a050acb4eec4723723170995606491750431bcdf81e9ecc"
    },
    "config.json": {
      "bytes": 179802,
      "sha256": "9ca97027fc253eb6ad14a2db0d0df5aec729403c8af8b4d59194c9e6a3dff458"
    },
    "model-00001.safetensors": {
      "file_bytes": 4131469166,
      "header_bytes": 12966,
      "header_sha256": "bc4087e229bf3928d2979f06be2432d3fa667f50e52cc2e01ec4502ff70e18b2"
    },
    "model-00012.safetensors": {
      "file_bytes": 8407550892,
      "header_bytes": 45676,
      "header_sha256": "520164d4953f27655cc42e6ab0c572a95ccd71c430e1579516552b4bc3e3e6b4"
    },
    "model-00013.safetensors": {
      "file_bytes": 8961483742,
      "header_bytes": 46422,
      "header_sha256": "cd61d5956d49179d0a45a1edd5bc403f813d34278df5febaf9854781c242ba5b"
    },
    "model-00014.safetensors": {
      "file_bytes": 9352636427,
      "header_bytes": 53475,
      "header_sha256": "10559a1168eac0bf3c789e6b909d8acb81290f6a2d366209376427591827261c"
    },
    "model-00015.safetensors": {
      "file_bytes": 9276066202,
      "header_bytes": 46866,
      "header_sha256": "31e39bd4a96b318fcab1d931a41d40c8d358ce7b567acab3a8d230a1b7a07476"
    },
    "model-00016.safetensors": {
      "file_bytes": 9269109257,
      "header_bytes": 46913,
      "header_sha256": "dca25658eac86fddde067f19b7c517089a4ccacb3282b721b91a0688769ccc09"
    },
    "model-00017.safetensors": {
      "file_bytes": 9142915130,
      "header_bytes": 53522,
      "header_sha256": "572b37f7b9abed22dda9509d44c8347bc327eb8553e455f6bc7af19148b94207"
    },
    "model-00018.safetensors": {
      "file_bytes": 9171205445,
      "header_bytes": 46781,
      "header_sha256": "bbfe94ba77dafc4bcbd3e318f83b53126c8de005018768c850cf01457b51b7e3"
    },
    "model-00019.safetensors": {
      "file_bytes": 3981319708,
      "header_bytes": 21108,
      "header_sha256": "0511bcffef20a6bbffbfc2fb9cc8183592bd34e96069cfc11b5ed83b3f7b43f5"
    },
    "model-ple-0000.safetensors": {
      "file_bytes": 225002544,
      "header_bytes": 432,
      "header_sha256": "7aab8df2d05d98da37a230ac93812baeed4cd32674fa16f3e2452e4447ae359e"
    },
    "model-ple-0001.safetensors": {
      "file_bytes": 225002542,
      "header_bytes": 430,
      "header_sha256": "e31874d09279b48929881a8ca93ab441d3cdec4ed0894d966e8141de95ac1399"
    },
    "model-ple-0002.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "c477f22bf097617d4e5d25a5689577b2a9894b30f00287267c33afcb4b19a7ef"
    },
    "model-ple-0003.safetensors": {
      "file_bytes": 225002550,
      "header_bytes": 438,
      "header_sha256": "44194dba1118d4e78e0e54ee3ac14ec3fd06a879842bad3f5d82a2a955bcea5c"
    },
    "model-ple-0004.safetensors": {
      "file_bytes": 225002550,
      "header_bytes": 438,
      "header_sha256": "f5dd8c6b20377dc14c3f072a750e6546d9ae5e6c08862fd08ed3fa88157cf2b7"
    },
    "model-ple-0005.safetensors": {
      "file_bytes": 225002548,
      "header_bytes": 436,
      "header_sha256": "eaf07af62586bd8c8aa1c2164107d0a621db0d8f97afd78b6a03f980f544f818"
    },
    "model-ple-0006.safetensors": {
      "file_bytes": 225002548,
      "header_bytes": 436,
      "header_sha256": "9ec2c3fecbe085c90ff3fd1dde7d88942bb59daef16029dae19daa45504ea382"
    },
    "model-ple-0007.safetensors": {
      "file_bytes": 225002548,
      "header_bytes": 436,
      "header_sha256": "888f3e6665cb800d7b01026e5f62082ccdf296e5a3a3f1d8d3039fcc55a71e01"
    },
    "model-ple-0008.safetensors": {
      "file_bytes": 225002550,
      "header_bytes": 438,
      "header_sha256": "d7593504c3d65def5ee14a4b423c3e7b164746db2105850aa5e5a00020111ed6"
    },
    "model-ple-0009.safetensors": {
      "file_bytes": 225002550,
      "header_bytes": 438,
      "header_sha256": "b63b817b74d4c7b8af6efcbd913f77da93680c66f14c53afc2d2358dfef53ef2"
    },
    "model-ple-0010.safetensors": {
      "file_bytes": 225002550,
      "header_bytes": 438,
      "header_sha256": "0e9d8d574a43b5a747c7df78e29c814e2bfb3108679e5b7d097a343cb50d143f"
    },
    "model-ple-0011.safetensors": {
      "file_bytes": 225002550,
      "header_bytes": 438,
      "header_sha256": "4bbd1fd83b597fb54a5f4e23a08eca634d073bc9587637aaeba7bd24589a31b1"
    },
    "model-ple-0012.safetensors": {
      "file_bytes": 225002550,
      "header_bytes": 438,
      "header_sha256": "be396ab5d0464a762996f3cbddba754b7edcd3ad175ac2fd579b1069b508af98"
    },
    "model-ple-0013.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "65abb6ef2f367236f27c135932816556dab8da35fa56bc4259a4dee4cf92395c"
    },
    "model-ple-0014.safetensors": {
      "file_bytes": 225002550,
      "header_bytes": 438,
      "header_sha256": "b3856fdab9e7ac3a40555ded1f10f0c799d0ecc867de486a00600b85de481851"
    },
    "model-ple-0015.safetensors": {
      "file_bytes": 225002550,
      "header_bytes": 438,
      "header_sha256": "c9e9eb961f050dc5af29824c545f92430cbc695c998b9eb189fe1cfe52b48bbd"
    },
    "model-ple-0016.safetensors": {
      "file_bytes": 225002550,
      "header_bytes": 438,
      "header_sha256": "efcbe4f1196a81d28dea41bdd8c009f6248454d9af26bb0c6999afdc2c04a86e"
    },
    "model-ple-0017.safetensors": {
      "file_bytes": 225002550,
      "header_bytes": 438,
      "header_sha256": "aa3dc0dec1e2bb7a38745b24a600632a6f7a75a0e4c9b5e0c01bcf131d86a67f"
    },
    "model-ple-0018.safetensors": {
      "file_bytes": 225002548,
      "header_bytes": 436,
      "header_sha256": "23dc87f881eb73f808263b5e866c7ffaa5923b2f7c9baf542cb39c010f0325d3"
    },
    "model-ple-0019.safetensors": {
      "file_bytes": 225002550,
      "header_bytes": 438,
      "header_sha256": "29c4f485d74a53ba41edf95c55ea5abb8538c29f9eab8901bb2c92aa26151896"
    },
    "model-ple-0020.safetensors": {
      "file_bytes": 225002548,
      "header_bytes": 436,
      "header_sha256": "f2add39714824a70c33eed02a138a4fad9d07e2146c64cea0db45fc3f04c1f86"
    },
    "model-ple-0021.safetensors": {
      "file_bytes": 225002548,
      "header_bytes": 436,
      "header_sha256": "498569d4574ce82556499e4d6a96dad86ca3dc2b603bd3e69235803b88632ec9"
    },
    "model-ple-0022.safetensors": {
      "file_bytes": 225002550,
      "header_bytes": 438,
      "header_sha256": "27e57e4990891ce1fc28470f1947abb2c8708710354f6d444f49e6435c9c879b"
    },
    "model-ple-0023.safetensors": {
      "file_bytes": 225002550,
      "header_bytes": 438,
      "header_sha256": "fbcaaf57b12a242f191f6952063f74311fd5112c4b5f984e20f4cc4959e0bcbb"
    },
    "model-ple-0024.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "fb1a39c9dc212dfe4cdeb51b187526fed3c610de304fccb74545419e6f5caf2f"
    },
    "model-ple-0025.safetensors": {
      "file_bytes": 225002550,
      "header_bytes": 438,
      "header_sha256": "b84c7d28b4324c6079ae2dc77993821b0a63f4d8248b3302c135b62ce2e2d346"
    },
    "model-ple-0026.safetensors": {
      "file_bytes": 225002548,
      "header_bytes": 436,
      "header_sha256": "232b651c69c938a548860c4bbb63625066c9f3b4574def62e3504ee609888554"
    },
    "model-ple-0027.safetensors": {
      "file_bytes": 225002550,
      "header_bytes": 438,
      "header_sha256": "844d8932fc965b9858f006b385112cda6ac1e535319d286877ba76ace1233f4a"
    },
    "model-ple-0028.safetensors": {
      "file_bytes": 225002548,
      "header_bytes": 436,
      "header_sha256": "50fb4f60c93186d4b1328554781345ff166bd858b74e5c28c3b26d26982520ee"
    },
    "model-ple-0029.safetensors": {
      "file_bytes": 225002550,
      "header_bytes": 438,
      "header_sha256": "2fe38b68d559e36d17de268309ac5782d359902ed9d6f0be06729ce9afecac28"
    },
    "model-ple-0030.safetensors": {
      "file_bytes": 225002550,
      "header_bytes": 438,
      "header_sha256": "8f623af7360fea0c9a8afb8374a2f6c5ddf6a981a2bf5f8437e3f7f970e3883d"
    },
    "model-ple-0031.safetensors": {
      "file_bytes": 225002548,
      "header_bytes": 436,
      "header_sha256": "121e7a3e9f8379c209c15549b52d2d5d1cd2d743a9735683e50becb597d2e289"
    },
    "model-ple-0032.safetensors": {
      "file_bytes": 225002550,
      "header_bytes": 438,
      "header_sha256": "7c6e4a0db19edf271f23c998c2a30f950ec2d53b6caeeee0a9f51e612e0a73dd"
    },
    "model-ple-0033.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "2097519fae7d72ae4e15a6e625c712e1a9dae08e130515e702ded423e65bc378"
    },
    "model-ple-0034.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "fd20def401dbe1d87ead3bb137881b0c0f7ccb7670cca11acbdf2bd4ca4d700a"
    },
    "model-ple-0035.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "d61ebe579a9666250451f7536e09cf0bcc4abae20a43f0c31f1be08538a05fc2"
    },
    "model-ple-0036.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "a88bc1e1fc1bc62427a8839e8e89882e9a6d6ab16ab2b8f72a401ac2f86e95ab"
    },
    "model-ple-0037.safetensors": {
      "file_bytes": 225002545,
      "header_bytes": 433,
      "header_sha256": "2ad17732ec3a1099b1238b8a069f69973c39f214d7db3855acde58b523c5590c"
    },
    "model-ple-0038.safetensors": {
      "file_bytes": 225002545,
      "header_bytes": 433,
      "header_sha256": "56042d9772673e88c3e36536d510866779d9ac266e2aa1126bcf65e9679d9b98"
    },
    "model-ple-0039.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "783898c4a906f76c4b0e093c16ac68cefbe0320f37d2da1a02aa096acc459cff"
    },
    "model-ple-0040.safetensors": {
      "file_bytes": 225002544,
      "header_bytes": 432,
      "header_sha256": "fd2ff2bbf41825d13fc83764605b353cdde7b54d52573f9c0574911437f31ed5"
    },
    "model-ple-0041.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "3c17481bf048affb7c4b87caed0179fed02824ee256ebabd031ce7379d0e7c1a"
    },
    "model-ple-0042.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "4f8009a7273d75cba4f48b3f319b506f5351103d167327630367d365cb7fb70b"
    },
    "model-ple-0043.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "42f13df0eac43f42a2071221e6856c2528c356c86e59bfa09e7a9c5eef8debd7"
    },
    "model-ple-0044.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "4b9c38ee6b5ba2a5b5b1e858a353f2be4474081042aaf57a2897b36e266e85fe"
    },
    "model-ple-0045.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "ac1c012972203fac9238f2e1e1b4eec6ce58c7c668fba0f9b7b39df3d6007dba"
    },
    "model-ple-0046.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "7542c20e85179f776cbb53170f0a8727017556260a1744485020f86b0744d7ac"
    },
    "model-ple-0047.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "e5257289b39c54da53395fcfe6d76ee17d555f78184dc134951715aab4a38eb5"
    },
    "model-ple-0048.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "b2a918fc0ae67c754e16055ed67d1b5c2c1c04a2d2324f433f9b0d12f4f20e1a"
    },
    "model-ple-0049.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "d41f292cebe5091818fbed84e4bd3264dceeb357f48d3eb1e948d3b83574a1bd"
    },
    "model-ple-0050.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "2e1094bf9c19f3a4858a31dc66142b7741fb99005ecad82e885dba419a936bca"
    },
    "model-ple-0051.safetensors": {
      "file_bytes": 225002544,
      "header_bytes": 432,
      "header_sha256": "f1e5fcad9e8a2d5a0dc2493b49d132d1560fa83cfc97afb708044e95ccb85c23"
    },
    "model-ple-0052.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "50d3dfc90d5987b3c47a84a6d18d8e4624de1eb7b2a73c1c3fa9383b2cf3e7a7"
    },
    "model-ple-0053.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "ec2fce57d99438a6124c3b31ac5486b50a82cf8fe33877f451f14b19a4e68295"
    },
    "model-ple-0054.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "f4d13466db3a31533f2934d2a4fedc73734163d721a300a9f37cda1ac43d3f13"
    },
    "model-ple-0055.safetensors": {
      "file_bytes": 225002545,
      "header_bytes": 433,
      "header_sha256": "0ab38e0c6d9dbc2cd59f0be1dbfc4920ee2f9fc809bd5159a8af893e0d9648d4"
    },
    "model-ple-0056.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "c0707c8fc33e38d3049e05f25ae587c175b60466ccdd50cd26dd84c3bf7a00f0"
    },
    "model-ple-0057.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "2397786d52c722be155a67cb5c1432873300ed6dbb057d873f28aef7258bddcd"
    },
    "model-ple-0058.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "0926e80550b4d091eb78f98f013ea21c552145c37542fbb7da82ecce379c8785"
    },
    "model-ple-0059.safetensors": {
      "file_bytes": 225002545,
      "header_bytes": 433,
      "header_sha256": "30e2c79d248c2ae13c9f3b15ee9dd8f0a74381a2486e44beeee0e1cc40a85f17"
    },
    "model-ple-0060.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "df683ba4fe653961999a470f465fb177a2555c09c1584c5b5c3b880f4143865a"
    },
    "model-ple-0061.safetensors": {
      "file_bytes": 225002545,
      "header_bytes": 433,
      "header_sha256": "9a0d905d60eaa6ef3b681be9582088c397048fcf692fee0ffa7c5ef62b7af410"
    },
    "model-ple-0062.safetensors": {
      "file_bytes": 225002544,
      "header_bytes": 432,
      "header_sha256": "05859d949e971300613b3e2789cd779701003f1af463e8c3c8f240aee0b88d23"
    },
    "model-ple-0063.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "86df886b00968f70f862aecb758ce30999e4fc8f731a861350bf54813bc1acfa"
    },
    "model-ple-0064.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "3b160520eb40cfcfc1984f01a2bb906bd6a501346d9f6deccc4ee33c6f083bed"
    },
    "model-ple-0065.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "1c2f60865bb24f1024fcebaec4a81691166a4ee9332d1e922b54a27bc1a8cf53"
    },
    "model-ple-0066.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "5ae7025dc937e48e65e5bea9de4bf3c2d662187e17a7f3fd76d7e99bbd947ab3"
    },
    "model-ple-0067.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "994dded7da895599897c211aab1dbaf04a2db8dc943a294793000e831449ae37"
    },
    "model-ple-0068.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "4608c73fa328bd49ac3f1bc3560c614e73c6fd0ba5690009eb4785cd1445f45f"
    },
    "model-ple-0069.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "e24509bd8064d987f373fe15061992e336ea0e0ba19c29cea33a633261745d8c"
    },
    "model-ple-0070.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "8a97df7598f602bdbb925d0b8f911f04ef00245e423efd2913b1608f4b94bc04"
    },
    "model-ple-0071.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "a8d2b9f2635591b17eb73db427c8cb9a7a1da52c4fca997f975761f1f962e05b"
    },
    "model-ple-0072.safetensors": {
      "file_bytes": 225002545,
      "header_bytes": 433,
      "header_sha256": "bfc44958cbe314ac547d18ef2bdd89b3850063200967f32256fdc9e77f327474"
    },
    "model-ple-0073.safetensors": {
      "file_bytes": 225002544,
      "header_bytes": 432,
      "header_sha256": "bc3ecc1d1b5605c0ac4c076b31f2b47cbcb6c4333de1dda7ae791ac40d6c6e55"
    },
    "model-ple-0074.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "6db50182954b5116046385e56292cdec3f3d79cd9436cb055f0a6bbcd78c9c27"
    },
    "model-ple-0075.safetensors": {
      "file_bytes": 225002545,
      "header_bytes": 433,
      "header_sha256": "08d0d5d698532fc198538a998f8fd64f2319b7713d8d6a2ad9d28c9cea938588"
    },
    "model-ple-0076.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "c821b5c6f8548f933e036f570c26ed5025caa2646bba1fa74d17fdd808f43157"
    },
    "model-ple-0077.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "74a15d05daa6a62b5fa6eb1f543c34043b3368bde3ae927a425d5b35413a43ac"
    },
    "model-ple-0078.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "a0cf4b7f019f703ae45542757115f0ed9e05ca4c96c0a43011e303066633e31e"
    },
    "model-ple-0079.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "f26c6b95e43e99ac90a403229f7693e91279bf8b45b9c63a322d215e177d4377"
    },
    "model-ple-0080.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "69ec72f6792f7f60cbc3e7afe521100e9200c6b6b6fa91a5a72b9f3c689da6de"
    },
    "model-ple-0081.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "1b420d73442b05e9d028afd2a655ce9877dc844eefa9be068f2c7bb1a6452c2d"
    },
    "model-ple-0082.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "4da273adef7918bfff68c7bfd2b3421252a67760cad6abbbeff64f60adb3459c"
    },
    "model-ple-0083.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "e69ccc623a1bdcf0c358a4b6bbb2006a91533fdc0fe288061efae78d80bdae80"
    },
    "model-ple-0084.safetensors": {
      "file_bytes": 225002544,
      "header_bytes": 432,
      "header_sha256": "87119f289a56e5a7a7f08e165e628e796be382218549ed6e6c7e60b93352d4cb"
    },
    "model-ple-0085.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "d37fbd02cea39194742046682b449b27c2330e3d22cade67a4f98b73d16a8d96"
    },
    "model-ple-0086.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "780524156cb88c8e02a9c5b0945c05858dae309f939fc404df83ef4b6d4160fc"
    },
    "model-ple-0087.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "ea5ff22a986ec1fc12bdbaba04a027fe0c9e8c944f902deaca4669f072117c0a"
    },
    "model-ple-0088.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "e7693a7c97d7553917f6da70bb4d8ce673fe5201acbd6c2f512e07b09dd28345"
    },
    "model-ple-0089.safetensors": {
      "file_bytes": 225002545,
      "header_bytes": 433,
      "header_sha256": "f9fb315f9d48521aba0978c5bc07b56f070039ccaa87025c03a63b74be958a7d"
    },
    "model-ple-0090.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "0e702f172af83f18b9b194d2a60415567acbf44ea3383f2b9f036798709101cd"
    },
    "model-ple-0091.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "e3f352ea35f6094d7d44481ca2037ea23023eedb6f28ce7013b98fab7581e469"
    },
    "model-ple-0092.safetensors": {
      "file_bytes": 225002545,
      "header_bytes": 433,
      "header_sha256": "f08ea81e2740336c40d0528297c4c025bfe8c8ea5a910014713160e0cb5fe536"
    },
    "model-ple-0093.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "3c0400f1f90ae7fb8614ffd5489c367eb1a0b004c6387cdd152a0ece614520b3"
    },
    "model-ple-0094.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "d49d5a43c1f042199269ccb5e41728e5fd7afcc90bbe0fe9ee0a893cb5b74409"
    },
    "model-ple-0095.safetensors": {
      "file_bytes": 225002544,
      "header_bytes": 432,
      "header_sha256": "514ada0065d53e2fb2d3bd114b2da9a128e12ee98b79dd6b5964c9d43d5d7638"
    },
    "model-ple-0096.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "3aff54cc7953b62e73a1536cbb5ad4fc65f2ce52203b0e1373f9bf0848e8ca52"
    },
    "model-ple-0097.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "b3545b2e720a8961c308aea740ebacf7011576d39edb98f11a09cbe8da9b9cbe"
    },
    "model-ple-0098.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "0f849301682048a0cf7280bb882538a907950354a162686223232b9228be714c"
    },
    "model-ple-0099.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "9f31cb277e9deb06453ee9adc7217edef5d47405669a38366e5172e25e7de0cc"
    },
    "model-ple-0100.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "7434c1d83413ab4313da32f4c6a9043cb76a88ba9bedb29bd592c85ab7bf2060"
    },
    "model-ple-0101.safetensors": {
      "file_bytes": 225002545,
      "header_bytes": 433,
      "header_sha256": "adad265b25093a49e0c0b4250beea351aff93c2a2255d4aadaab9966a592c7d1"
    },
    "model-ple-0102.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "8c757119be29fa6d4857d7db3dcdaf36ed45b1bd1edfaab3fa17010753cb5b6a"
    },
    "model-ple-0103.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "92c79f0232ac90dda73d7ad9629d942d81319ecf961d0a9e43b76841ed506e0b"
    },
    "model-ple-0104.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "6406ee21aa85be4142493a8fee692efed8fe4e7e3c46c900f2b9b2d1b9ea1f30"
    },
    "model-ple-0105.safetensors": {
      "file_bytes": 225002545,
      "header_bytes": 433,
      "header_sha256": "35db29d6636320a9284ee85938b3f9a8834a2eee7116071df017fac16166e810"
    },
    "model-ple-0106.safetensors": {
      "file_bytes": 225002544,
      "header_bytes": 432,
      "header_sha256": "2ec190ef8fc4e07788522114b66f4307cc0c0fbe45bab03ac5ee314fc11c4ac4"
    },
    "model-ple-0107.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "562c4e20acfc0911ea72e1d967c30fc00cc14f9823ddc8e2cfc6d4a5c8b38e27"
    },
    "model-ple-0108.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "248a9d4d34d204fbab664969176f8c994a12eef7f1f554a797b5c9bd1d2f9b06"
    },
    "model-ple-0109.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "e4a7e020349569c01d2af9fa689384d1a3a6889e60103327d2f9e305f23c8c86"
    },
    "model-ple-0110.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "76afcd0b6931ba68cf3e8d0c7be8b3757af41e22cb220cab03ce146317a8efae"
    },
    "model-ple-0111.safetensors": {
      "file_bytes": 225002545,
      "header_bytes": 433,
      "header_sha256": "b68d71827f55948a04bbaf4efcc0cea144ddba9d5a640a43efd3ebe979d05137"
    },
    "model-ple-0112.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "c1f9f48e2088dea6094530de1678366632b7daefa0411eba8077e5f4e4fd8e5f"
    },
    "model-ple-0113.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "2b1de6037b9dadea0453b02cbd14a0235192feb402122f5f1e95485d1b3da787"
    },
    "model-ple-0114.safetensors": {
      "file_bytes": 225002545,
      "header_bytes": 433,
      "header_sha256": "1a2f2df24f41ae4850e45d2083694eb500cd4dd299f7a27750282cea5f53a609"
    },
    "model-ple-0115.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "bddc5dce53cb56abad00e6f2c5dbce211741ea801360bf987ed1c28263f61825"
    },
    "model-ple-0116.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "dabce0dce5a78c3b42c3023358a52ed50023b097f2385c0ea90e6767e733a28b"
    },
    "model-ple-0117.safetensors": {
      "file_bytes": 225002544,
      "header_bytes": 432,
      "header_sha256": "753cef535bbe71fbfc587052e2ce5c00cacc876a89f953d5e8ad2d44f076d3f8"
    },
    "model-ple-0118.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "b108ab6796263b11a07fa327feacdd0cd9fe54f491522b6c40ea4c2ad0c027cf"
    },
    "model-ple-0119.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "1ab9913c0d8f1855d193b894d1ce8f4ec3c56e63d1db654817ca31430abbf536"
    },
    "model-ple-0120.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "c3975e87303d37f2d28154a073f510d3d0280edb07bd4ee1c6a034148e26b1b1"
    },
    "model-ple-0121.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "439a2558736a49f932eb4a7c4104ee253965115eea612383d96088ab6541c79a"
    },
    "model-ple-0122.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "c77382c47092813e044d2fa39051f064e829c0553610d9154226cdee28c25549"
    },
    "model-ple-0123.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "c4d5e7416fa86bb260c548ba81e674bc222f550aab6aa27b1979c347713d7dbe"
    },
    "model-ple-0124.safetensors": {
      "file_bytes": 225002545,
      "header_bytes": 433,
      "header_sha256": "a2cebaa044fb5f9e14b820bcadf06df2ef8e8373bc9f8f19b42f9a7b3a7586c5"
    },
    "model-ple-0125.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "149b459c96e60bfb7861b8a73830ce5bec7c76b9f53f6970f2ef0e0f1277c76f"
    },
    "model-ple-0126.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "d4da7f968971cba3610caa47a0e146faf81ee1271a1742efedb5e3a2da6cfe8d"
    },
    "model-ple-0127.safetensors": {
      "file_bytes": 225002547,
      "header_bytes": 435,
      "header_sha256": "b9fc4b2f4155548df82e6819a12184b85f73d39276f8bad2a73ca87b008fd081"
    },
    "model-vision-graft.safetensors": {
      "file_bytes": 897899165,
      "header_bytes": 37045,
      "header_sha256": "d8af3732673896e8db1e6b86c4de86aed9f2251773ef695cfe7ca1be2a1ce538"
    },
    "model.py": {
      "bytes": 262311,
      "sha256": "1685ec90feb24e421c379ae4e3594f659478905d2c1393617990d84d3f514ee8"
    },
    "model.safetensors.index.json": {
      "bytes": 319322,
      "sha256": "b1ef3a95bc2f13061c06de84aea457469858474f0a34fb0cc98469a6cac11986"
    }
  },
  "network_bytes": 1244721,
  "qualification": {
    "memory": "unproven",
    "quality": "unproven",
    "runtime": "unproven",
    "speed": "unproven"
  },
  "repo": "TheDrainFlorist/Qwen3.8-Flash-Next-VQ-4.4bpw",
  "revision": "0f35dc817238bdbabdac208db731470cd30a7c0a",
  "schema": 1,
  "tensor_count": 3671,
  "vq_ngram_geometry": {
    "dim": 2,
    "group": 32,
    "iters": 12,
    "k": 256,
    "row_bytes": 80,
    "sample": 2000000,
    "seed": 1234
  }
}
```

## Reproduction

`python3 Tools/quantization_inventory.py --repo REPOSITORY --revision EXACT_REVISION --out NEW_DIRECTORY`

The output directory retains the full config, source runtime as inert text, tensor index, complete validated headers and the inventory. All selected revisions are frozen in `bench/quantization/screen-v1.json`.
