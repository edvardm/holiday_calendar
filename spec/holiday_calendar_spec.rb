require 'holiday_calendar'
require 'base64'

# base64-encoded finnish calendar.ics for the year 2013
ENCODED_DATA = "QkVHSU46VkNBTEVOREFSDQpQUk9ESUQ6LS8vR29vZ2xlIEluYy8vR29vZ2xl\nIENhbGVuZGFyIDcwLjkwNTQvL0VODQpWRVJTSU9OOjIuMA0KQ0FMU0NBTEU6\nR1JFR09SSUFODQpNRVRIT0Q6UFVCTElTSA0KWC1XUi1USU1FWk9ORTpVVEMN\nClgtV1ItQ0FMREVTQzpTdW9tYWxhaXNldCBqdWhsYXB5aMOkdA0KQkVHSU46\nVkVWRU5UDQpEVFNUQVJUO1ZBTFVFPURBVEU6MjAxMzA1MDENCkRURU5EO1ZB\nTFVFPURBVEU6MjAxMzA1MDINCkRUU1RBTVA6MjAxMzAxMDNUMTU1NDIzWg0K\nVUlEOmhAYjFkYmQ3OTBlYmMyOTQ3ZTI5ZTMxODgxNGQ1OGYzYjYwYWZiMzQy\nN0Bnb29nbGUuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xF\nPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1BQ0NFUFRFRDtYLU5VTS1HVUUN\nCiBTVFM9MDptYWlsdG86Y3BraXNwajlkcG42aXNyODRkazZ1cjM5Y2hnbmln\nMzdlOW5uYXMxZWVvbjY2b2JjY2xuNjhvYmk1cGptdXINCiByN2RoaWlzb3Jm\nZGslNDB2aXJ0dWFsDQpDTEFTUzpQVUJMSUMNCkNSRUFURUQ6MjAxMzAxMDNU\nMDY1NTQ1Wg0KTEFTVC1NT0RJRklFRDoyMDEzMDEwM1QwNjU1NDVaDQpTRVFV\nRU5DRToxDQpTVEFUVVM6Q09ORklSTUVEDQpTVU1NQVJZOlZhcHVucMOkaXbD\npA0KVFJBTlNQOk9QQVFVRQ0KRU5EOlZFVkVOVA0KQkVHSU46VkVWRU5UDQpE\nVFNUQVJUO1ZBTFVFPURBVEU6MjAxMjA1MDENCkRURU5EO1ZBTFVFPURBVEU6\nMjAxMjA1MDINCkRUU1RBTVA6MjAxMzAxMDNUMTU1NDIzWg0KVUlEOmhANTJl\nNTdkZTM5ODc3N2U5MGNjMTY0NjFkOThhZDU5MTc2NDQ1YjAyMEBnb29nbGUu\nY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJU\nSUNJUEFOVDtQQVJUU1RBVD1BQ0NFUFRFRDtYLU5VTS1HVUUNCiBTVFM9MDpt\nYWlsdG86Y3BraXNwajlkcG42aXNyODRkazZ1cjM5Y2hnbmlnMzdlOW5uYXMx\nZWVvbjY2b2JjY2xuNjhvYmk1cGptdXINCiByN2RoaWlzb3JmZGslNDB2aXJ0\ndWFsDQpDTEFTUzpQVUJMSUMNCkNSRUFURUQ6MjAxMzAxMDNUMDY1NTQ1Wg0K\nTEFTVC1NT0RJRklFRDoyMDEzMDEwM1QwNjU1NDVaDQpTRVFVRU5DRToxDQpT\nVEFUVVM6Q09ORklSTUVEDQpTVU1NQVJZOlZhcHVucMOkaXbDpA0KVFJBTlNQ\nOk9QQVFVRQ0KRU5EOlZFVkVOVA0KQkVHSU46VkVWRU5UDQpEVFNUQVJUO1ZB\nTFVFPURBVEU6MjAxNDA1MDENCkRURU5EO1ZBTFVFPURBVEU6MjAxNDA1MDIN\nCkRUU1RBTVA6MjAxMzAxMDNUMTU1NDIzWg0KVUlEOmhANDljMjFmZjRlNDkx\nZDFjN2FhNDczNTE1ODVlYzE3MmY5N2YzNTIwNkBnb29nbGUuY29tDQpBVFRF\nTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQ\nQVJUU1RBVD1BQ0NFUFRFRDtYLU5VTS1HVUUNCiBTVFM9MDptYWlsdG86Y3Br\naXNwajlkcG42aXNyODRkazZ1cjM5Y2hnbmlnMzdlOW5uYXMxZWVvbjY2b2Jj\nY2xuNjhvYmk1cGptdXINCiByN2RoaWlzb3JmZGslNDB2aXJ0dWFsDQpDTEFT\nUzpQVUJMSUMNCkNSRUFURUQ6MjAxMzAxMDNUMDY1NTQ1Wg0KTEFTVC1NT0RJ\nRklFRDoyMDEzMDEwM1QwNjU1NDVaDQpTRVFVRU5DRToxDQpTVEFUVVM6Q09O\nRklSTUVEDQpTVU1NQVJZOlZhcHVucMOkaXbDpA0KVFJBTlNQOk9QQVFVRQ0K\nRU5EOlZFVkVOVA0KQkVHSU46VkVWRU5UDQpEVFNUQVJUO1ZBTFVFPURBVEU6\nMjAxMjAxMDENCkRURU5EO1ZBTFVFPURBVEU6MjAxMjAxMDINCkRUU1RBTVA6\nMjAxMzAxMDNUMTU1NDIzWg0KVUlEOmhAY2YyNjk5NzU3YzQ5Njg1MjdiOTE4\nNDQzMTM1ZGNmODJhYjBjMTljOUBnb29nbGUuY29tDQpBVFRFTkRFRTtDVVRZ\nUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1B\nQ0NFUFRFRDtYLU5VTS1HVUUNCiBTVFM9MDptYWlsdG86Y3BraXNwajlkcG42\naXNyODRkazZ1cjM5Y2hnbmlnMzdlOW5uYXMxZWVvbjY2b2JjY2xuNjhvYmk1\ncGptdXINCiByN2RoaWlzb3JmZGslNDB2aXJ0dWFsDQpDTEFTUzpQVUJMSUMN\nCkNSRUFURUQ6MjAxMzAxMDNUMDY1NTQ1Wg0KTEFTVC1NT0RJRklFRDoyMDEz\nMDEwM1QwNjU1NDVaDQpTRVFVRU5DRToxDQpTVEFUVVM6Q09ORklSTUVEDQpT\nVU1NQVJZOlV1ZGVudnVvZGVucMOkaXbDpA0KVFJBTlNQOk9QQVFVRQ0KRU5E\nOlZFVkVOVA0KQkVHSU46VkVWRU5UDQpEVFNUQVJUO1ZBTFVFPURBVEU6MjAx\nMzAxMDENCkRURU5EO1ZBTFVFPURBVEU6MjAxMzAxMDINCkRUU1RBTVA6MjAx\nMzAxMDNUMTU1NDIzWg0KVUlEOmhAMWQ4NjFiMTYwMmVlZDM0ZTIzZDIwOTE2\nNGE1OTAwMzMyOTlkNmRkZUBnb29nbGUuY29tDQpBVFRFTkRFRTtDVVRZUEU9\nSU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1BQ0NF\nUFRFRDtYLU5VTS1HVUUNCiBTVFM9MDptYWlsdG86Y3BraXNwajlkcG42aXNy\nODRkazZ1cjM5Y2hnbmlnMzdlOW5uYXMxZWVvbjY2b2JjY2xuNjhvYmk1cGpt\ndXINCiByN2RoaWlzb3JmZGslNDB2aXJ0dWFsDQpDTEFTUzpQVUJMSUMNCkNS\nRUFURUQ6MjAxMzAxMDNUMDY1NTQ1Wg0KTEFTVC1NT0RJRklFRDoyMDEzMDEw\nM1QwNjU1NDVaDQpTRVFVRU5DRToxDQpTVEFUVVM6Q09ORklSTUVEDQpTVU1N\nQVJZOlV1ZGVudnVvZGVucMOkaXbDpA0KVFJBTlNQOk9QQVFVRQ0KRU5EOlZF\nVkVOVA0KQkVHSU46VkVWRU5UDQpEVFNUQVJUO1ZBTFVFPURBVEU6MjAxNDAx\nMDENCkRURU5EO1ZBTFVFPURBVEU6MjAxNDAxMDINCkRUU1RBTVA6MjAxMzAx\nMDNUMTU1NDIzWg0KVUlEOmhAMTM0YjcyMzc2N2QyMDYxYjE4NWQ1YjkzYzc2\nNWFkZWIwNmIyYmFlY0Bnb29nbGUuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5E\nSVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1BQ0NFUFRF\nRDtYLU5VTS1HVUUNCiBTVFM9MDptYWlsdG86Y3BraXNwajlkcG42aXNyODRk\nazZ1cjM5Y2hnbmlnMzdlOW5uYXMxZWVvbjY2b2JjY2xuNjhvYmk1cGptdXIN\nCiByN2RoaWlzb3JmZGslNDB2aXJ0dWFsDQpDTEFTUzpQVUJMSUMNCkNSRUFU\nRUQ6MjAxMzAxMDNUMDY1NTQ1Wg0KTEFTVC1NT0RJRklFRDoyMDEzMDEwM1Qw\nNjU1NDVaDQpTRVFVRU5DRToxDQpTVEFUVVM6Q09ORklSTUVEDQpTVU1NQVJZ\nOlV1ZGVudnVvZGVucMOkaXbDpA0KVFJBTlNQOk9QQVFVRQ0KRU5EOlZFVkVO\nVA0KQkVHSU46VkVWRU5UDQpEVFNUQVJUO1ZBTFVFPURBVEU6MjAxMjEyMjYN\nCkRURU5EO1ZBTFVFPURBVEU6MjAxMjEyMjcNCkRUU1RBTVA6MjAxMzAxMDNU\nMTU1NDIzWg0KVUlEOmhAZGY1ZmU3MThiMGQyZTBjZTllYWFkYzc4MjU5ODQ3\nZGRmMGVkMDFmOUBnb29nbGUuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJ\nRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1BQ0NFUFRFRDtY\nLU5VTS1HVUUNCiBTVFM9MDptYWlsdG86Y3BraXNwajlkcG42aXNyODRkazZ1\ncjM5Y2hnbmlnMzdlOW5uYXMxZWVvbjY2b2JjY2xuNjhvYmk1cGptdXINCiBy\nN2RoaWlzb3JmZGslNDB2aXJ0dWFsDQpDTEFTUzpQVUJMSUMNCkNSRUFURUQ6\nMjAxMzAxMDNUMDY1NTQ1Wg0KTEFTVC1NT0RJRklFRDoyMDEzMDEwM1QwNjU1\nNDVaDQpTRVFVRU5DRToxDQpTVEFUVVM6Q09ORklSTUVEDQpTVU1NQVJZOlRh\ncGFuaW5ww6RpdsOkDQpUUkFOU1A6T1BBUVVFDQpFTkQ6VkVWRU5UDQpCRUdJ\nTjpWRVZFTlQNCkRUU1RBUlQ7VkFMVUU9REFURToyMDE0MTIyNg0KRFRFTkQ7\nVkFMVUU9REFURToyMDE0MTIyNw0KRFRTVEFNUDoyMDEzMDEwM1QxNTU0MjNa\nDQpVSUQ6aEAyNTI0NmRlY2NhNDY0ZDRlMjczNTFhMDI5NDRjNmUxNmY3OWNh\nMDA2QGdvb2dsZS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JP\nTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPUFDQ0VQVEVEO1gtTlVNLUdV\nRQ0KIFNUUz0wOm1haWx0bzpjcGtpc3BqOWRwbjZpc3I4NGRrNnVyMzljaGdu\naWczN2U5bm5hczFlZW9uNjZvYmNjbG42OG9iaTVwam11cg0KIHI3ZGhpaXNv\ncmZkayU0MHZpcnR1YWwNCkNMQVNTOlBVQkxJQw0KQ1JFQVRFRDoyMDEzMDEw\nM1QwNjU1NDVaDQpMQVNULU1PRElGSUVEOjIwMTMwMTAzVDA2NTU0NVoNClNF\nUVVFTkNFOjENClNUQVRVUzpDT05GSVJNRUQNClNVTU1BUlk6VGFwYW5pbnDD\npGl2w6QNClRSQU5TUDpPUEFRVUUNCkVORDpWRVZFTlQNCkJFR0lOOlZFVkVO\nVA0KRFRTVEFSVDtWQUxVRT1EQVRFOjIwMTMxMjI2DQpEVEVORDtWQUxVRT1E\nQVRFOjIwMTMxMjI3DQpEVFNUQU1QOjIwMTMwMTAzVDE1NTQyM1oNClVJRDpo\nQDFjYzY1MjI2ZTgwZWZjZTg3OWU4MmU3MjQwNDk3OWFhYjljMGQ2YzZAZ29v\nZ2xlLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEt\nUEFSVElDSVBBTlQ7UEFSVFNUQVQ9QUNDRVBURUQ7WC1OVU0tR1VFDQogU1RT\nPTA6bWFpbHRvOmNwa2lzcGo5ZHBuNmlzcjg0ZGs2dXIzOWNoZ25pZzM3ZTlu\nbmFzMWVlb242Nm9iY2NsbjY4b2JpNXBqbXVyDQogcjdkaGlpc29yZmRrJTQw\ndmlydHVhbA0KQ0xBU1M6UFVCTElDDQpDUkVBVEVEOjIwMTMwMTAzVDA2NTU0\nNVoNCkxBU1QtTU9ESUZJRUQ6MjAxMzAxMDNUMDY1NTQ1Wg0KU0VRVUVOQ0U6\nMQ0KU1RBVFVTOkNPTkZJUk1FRA0KU1VNTUFSWTpUYXBhbmlucMOkaXbDpA0K\nVFJBTlNQOk9QQVFVRQ0KRU5EOlZFVkVOVA0KQkVHSU46VkVWRU5UDQpEVFNU\nQVJUO1ZBTFVFPURBVEU6MjAxNDA0MjANCkRURU5EO1ZBTFVFPURBVEU6MjAx\nNDA0MjENCkRUU1RBTVA6MjAxMzAxMDNUMTU1NDIzWg0KVUlEOmhAOTI5NjE4\nNTFhYjY2NTdhNWQ2NGQxMWNjMTVmYjM2NGFmNWYwODkxOUBnb29nbGUuY29t\nDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJ\nUEFOVDtQQVJUU1RBVD1BQ0NFUFRFRDtYLU5VTS1HVUUNCiBTVFM9MDptYWls\ndG86Y3BraXNwajlkcG42aXNyODRkazZ1cjM5Y2hnbmlnMzdlOW5uYXMxZWVv\nbjY2b2JjY2xuNjhvYmk1cGptdXINCiByN2RoaWlzb3JmZGslNDB2aXJ0dWFs\nDQpDTEFTUzpQVUJMSUMNCkNSRUFURUQ6MjAxMzAxMDNUMDY1NTQ1Wg0KTEFT\nVC1NT0RJRklFRDoyMDEzMDEwM1QwNjU1NDVaDQpTRVFVRU5DRToxDQpTVEFU\nVVM6Q09ORklSTUVEDQpTVU1NQVJZOlDDpMOkc2nDpGlzc3VubnVudGFpDQpU\nUkFOU1A6T1BBUVVFDQpFTkQ6VkVWRU5UDQpCRUdJTjpWRVZFTlQNCkRUU1RB\nUlQ7VkFMVUU9REFURToyMDEzMDMzMQ0KRFRFTkQ7VkFMVUU9REFURToyMDEz\nMDQwMQ0KRFRTVEFNUDoyMDEzMDEwM1QxNTU0MjNaDQpVSUQ6aEA3MjM3ZWY3\nY2E1OTc1YzI2NmQzNGNlMDk4OWNmMmY3MDBjOWY5NGFmQGdvb2dsZS5jb20N\nCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQ\nQU5UO1BBUlRTVEFUPUFDQ0VQVEVEO1gtTlVNLUdVRQ0KIFNUUz0wOm1haWx0\nbzpjcGtpc3BqOWRwbjZpc3I4NGRrNnVyMzljaGduaWczN2U5bm5hczFlZW9u\nNjZvYmNjbG42OG9iaTVwam11cg0KIHI3ZGhpaXNvcmZkayU0MHZpcnR1YWwN\nCkNMQVNTOlBVQkxJQw0KQ1JFQVRFRDoyMDEzMDEwM1QwNjU1NDVaDQpMQVNU\nLU1PRElGSUVEOjIwMTMwMTAzVDA2NTU0NVoNClNFUVVFTkNFOjENClNUQVRV\nUzpDT05GSVJNRUQNClNVTU1BUlk6UMOkw6RzacOkaXNzdW5udW50YWkNClRS\nQU5TUDpPUEFRVUUNCkVORDpWRVZFTlQNCkJFR0lOOlZFVkVOVA0KRFRTVEFS\nVDtWQUxVRT1EQVRFOjIwMTMxMTAyDQpEVEVORDtWQUxVRT1EQVRFOjIwMTMx\nMTAzDQpEVFNUQU1QOjIwMTMwMTAzVDE1NTQyM1oNClVJRDpoQGUwMmM1ODg3\nNTRlMmIyMGI2ZjdmOTdkOGViN2U2MDAzZTcyZGI4YmVAZ29vZ2xlLmNvbQ0K\nQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBB\nTlQ7UEFSVFNUQVQ9QUNDRVBURUQ7WC1OVU0tR1VFDQogU1RTPTA6bWFpbHRv\nOmNwa2lzcGo5ZHBuNmlzcjg0ZGs2dXIzOWNoZ25pZzM3ZTlubmFzMWVlb242\nNm9iY2NsbjY4b2JpNXBqbXVyDQogcjdkaGlpc29yZmRrJTQwdmlydHVhbA0K\nQ0xBU1M6UFVCTElDDQpDUkVBVEVEOjIwMTMwMTAzVDA2NTU0NVoNCkxBU1Qt\nTU9ESUZJRUQ6MjAxMzAxMDNUMDY1NTQ1Wg0KU0VRVUVOQ0U6MQ0KU1RBVFVT\nOkNPTkZJUk1FRA0KU1VNTUFSWTpQeWjDpGlucMOkaXbDpA0KVFJBTlNQOk9Q\nQVFVRQ0KRU5EOlZFVkVOVA0KQkVHSU46VkVWRU5UDQpEVFNUQVJUO1ZBTFVF\nPURBVEU6MjAxNDExMDENCkRURU5EO1ZBTFVFPURBVEU6MjAxNDExMDINCkRU\nU1RBTVA6MjAxMzAxMDNUMTU1NDIzWg0KVUlEOmhAZDUxNWQ0ZjA4YTY3Njdk\nZmYwYzQyMDEzODAxMWQ1OTFmZjZiMWE2MkBnb29nbGUuY29tDQpBVFRFTkRF\nRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJU\nU1RBVD1BQ0NFUFRFRDtYLU5VTS1HVUUNCiBTVFM9MDptYWlsdG86Y3BraXNw\najlkcG42aXNyODRkazZ1cjM5Y2hnbmlnMzdlOW5uYXMxZWVvbjY2b2JjY2xu\nNjhvYmk1cGptdXINCiByN2RoaWlzb3JmZGslNDB2aXJ0dWFsDQpDTEFTUzpQ\nVUJMSUMNCkNSRUFURUQ6MjAxMzAxMDNUMDY1NTQ1Wg0KTEFTVC1NT0RJRklF\nRDoyMDEzMDEwM1QwNjU1NDVaDQpTRVFVRU5DRToxDQpTVEFUVVM6Q09ORklS\nTUVEDQpTVU1NQVJZOlB5aMOkaW5ww6RpdsOkDQpUUkFOU1A6T1BBUVVFDQpF\nTkQ6VkVWRU5UDQpCRUdJTjpWRVZFTlQNCkRUU1RBUlQ7VkFMVUU9REFURToy\nMDE0MDQxOA0KRFRFTkQ7VkFMVUU9REFURToyMDE0MDQxOQ0KRFRTVEFNUDoy\nMDEzMDEwM1QxNTU0MjNaDQpVSUQ6aEA4YmRkN2Q1OTAyMTVhZjdlMjVmY2Uz\nMzY4NGEwYWY2NDE0NjAyNmMwQGdvb2dsZS5jb20NCkFUVEVOREVFO0NVVFlQ\nRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPUFD\nQ0VQVEVEO1gtTlVNLUdVRQ0KIFNUUz0wOm1haWx0bzpjcGtpc3BqOWRwbjZp\nc3I4NGRrNnVyMzljaGduaWczN2U5bm5hczFlZW9uNjZvYmNjbG42OG9iaTVw\nam11cg0KIHI3ZGhpaXNvcmZkayU0MHZpcnR1YWwNCkNMQVNTOlBVQkxJQw0K\nQ1JFQVRFRDoyMDEzMDEwM1QwNjU1NDVaDQpMQVNULU1PRElGSUVEOjIwMTMw\nMTAzVDA2NTU0NVoNClNFUVVFTkNFOjENClNUQVRVUzpDT05GSVJNRUQNClNV\nTU1BUlk6UGl0a8OkcGVyamFudGFpDQpUUkFOU1A6T1BBUVVFDQpFTkQ6VkVW\nRU5UDQpCRUdJTjpWRVZFTlQNCkRUU1RBUlQ7VkFMVUU9REFURToyMDEzMDMy\nOQ0KRFRFTkQ7VkFMVUU9REFURToyMDEzMDMzMA0KRFRTVEFNUDoyMDEzMDEw\nM1QxNTU0MjNaDQpVSUQ6aEA1NjRlNDFjOGRkMmMwMzQ2NmMxZGFkNTVkMzUx\nZWUyY2ZhZmQ3ZjY4QGdvb2dsZS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJ\nVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPUFDQ0VQVEVE\nO1gtTlVNLUdVRQ0KIFNUUz0wOm1haWx0bzpjcGtpc3BqOWRwbjZpc3I4NGRr\nNnVyMzljaGduaWczN2U5bm5hczFlZW9uNjZvYmNjbG42OG9iaTVwam11cg0K\nIHI3ZGhpaXNvcmZkayU0MHZpcnR1YWwNCkNMQVNTOlBVQkxJQw0KQ1JFQVRF\nRDoyMDEzMDEwM1QwNjU1NDVaDQpMQVNULU1PRElGSUVEOjIwMTMwMTAzVDA2\nNTU0NVoNClNFUVVFTkNFOjENClNUQVRVUzpDT05GSVJNRUQNClNVTU1BUlk6\nUGl0a8OkcGVyamFudGFpDQpUUkFOU1A6T1BBUVVFDQpFTkQ6VkVWRU5UDQpC\nRUdJTjpWRVZFTlQNCkRUU1RBUlQ7VkFMVUU9REFURToyMDE0MDEwNg0KRFRF\nTkQ7VkFMVUU9REFURToyMDE0MDEwNw0KRFRTVEFNUDoyMDEzMDEwM1QxNTU0\nMjNaDQpVSUQ6aEBhYjBlNmZiNDIxYTZlY2Q2MTY0YzdhNmQyN2U2YTczMjFm\nZWVhOWNmQGdvb2dsZS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFM\nO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPUFDQ0VQVEVEO1gtTlVN\nLUdVRQ0KIFNUUz0wOm1haWx0bzpjcGtpc3BqOWRwbjZpc3I4NGRrNnVyMzlj\naGduaWczN2U5bm5hczFlZW9uNjZvYmNjbG42OG9iaTVwam11cg0KIHI3ZGhp\naXNvcmZkayU0MHZpcnR1YWwNCkNMQVNTOlBVQkxJQw0KQ1JFQVRFRDoyMDEz\nMDEwM1QwNjU1NDVaDQpMQVNULU1PRElGSUVEOjIwMTMwMTAzVDA2NTU0NVoN\nClNFUVVFTkNFOjENClNUQVRVUzpDT05GSVJNRUQNClNVTU1BUlk6TG9wcGlh\naW5lbg0KVFJBTlNQOk9QQVFVRQ0KRU5EOlZFVkVOVA0KQkVHSU46VkVWRU5U\nDQpEVFNUQVJUO1ZBTFVFPURBVEU6MjAxMjAxMDYNCkRURU5EO1ZBTFVFPURB\nVEU6MjAxMjAxMDcNCkRUU1RBTVA6MjAxMzAxMDNUMTU1NDIzWg0KVUlEOmhA\nODEyYjU2MTlkN2RiNmFmYjYxNTM5MDcyMmU5NzE1MzU3YjZkMzJjMkBnb29n\nbGUuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1Q\nQVJUSUNJUEFOVDtQQVJUU1RBVD1BQ0NFUFRFRDtYLU5VTS1HVUUNCiBTVFM9\nMDptYWlsdG86Y3BraXNwajlkcG42aXNyODRkazZ1cjM5Y2hnbmlnMzdlOW5u\nYXMxZWVvbjY2b2JjY2xuNjhvYmk1cGptdXINCiByN2RoaWlzb3JmZGslNDB2\naXJ0dWFsDQpDTEFTUzpQVUJMSUMNCkNSRUFURUQ6MjAxMzAxMDNUMDY1NTQ1\nWg0KTEFTVC1NT0RJRklFRDoyMDEzMDEwM1QwNjU1NDVaDQpTRVFVRU5DRTox\nDQpTVEFUVVM6Q09ORklSTUVEDQpTVU1NQVJZOkxvcHBpYWluZW4NClRSQU5T\nUDpPUEFRVUUNCkVORDpWRVZFTlQNCkJFR0lOOlZFVkVOVA0KRFRTVEFSVDtW\nQUxVRT1EQVRFOjIwMTMwMTA2DQpEVEVORDtWQUxVRT1EQVRFOjIwMTMwMTA3\nDQpEVFNUQU1QOjIwMTMwMTAzVDE1NTQyM1oNClVJRDpoQDU2YWZlYmQ0OGIz\nZmFkMzVlODA5M2I0ZGQxOGY2ZmM3ZjE1Y2NlMjVAZ29vZ2xlLmNvbQ0KQVRU\nRU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7\nUEFSVFNUQVQ9QUNDRVBURUQ7WC1OVU0tR1VFDQogU1RTPTA6bWFpbHRvOmNw\na2lzcGo5ZHBuNmlzcjg0ZGs2dXIzOWNoZ25pZzM3ZTlubmFzMWVlb242Nm9i\nY2NsbjY4b2JpNXBqbXVyDQogcjdkaGlpc29yZmRrJTQwdmlydHVhbA0KQ0xB\nU1M6UFVCTElDDQpDUkVBVEVEOjIwMTMwMTAzVDA2NTU0NVoNCkxBU1QtTU9E\nSUZJRUQ6MjAxMzAxMDNUMDY1NTQ1Wg0KU0VRVUVOQ0U6MQ0KU1RBVFVTOkNP\nTkZJUk1FRA0KU1VNTUFSWTpMb3BwaWFpbmVuDQpUUkFOU1A6T1BBUVVFDQpF\nTkQ6VkVWRU5UDQpCRUdJTjpWRVZFTlQNCkRUU1RBUlQ7VkFMVUU9REFURToy\nMDE0MDYyMQ0KRFRFTkQ7VkFMVUU9REFURToyMDE0MDYyMg0KRFRTVEFNUDoy\nMDEzMDEwM1QxNTU0MjNaDQpVSUQ6aEA3Yzk1ZjUxNzZiYzM5Y2JmNmFjNzNi\nMmRhMGU0ZDIxYjBiZmU3Y2YzQGdvb2dsZS5jb20NCkFUVEVOREVFO0NVVFlQ\nRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPUFD\nQ0VQVEVEO1gtTlVNLUdVRQ0KIFNUUz0wOm1haWx0bzpjcGtpc3BqOWRwbjZp\nc3I4NGRrNnVyMzljaGduaWczN2U5bm5hczFlZW9uNjZvYmNjbG42OG9iaTVw\nam11cg0KIHI3ZGhpaXNvcmZkayU0MHZpcnR1YWwNCkNMQVNTOlBVQkxJQw0K\nQ1JFQVRFRDoyMDEzMDEwM1QwNjU1NDVaDQpMQVNULU1PRElGSUVEOjIwMTMw\nMTAzVDA2NTU0NVoNClNFUVVFTkNFOjENClNUQVRVUzpDT05GSVJNRUQNClNV\nTU1BUlk6SnVoYW5udXNww6RpdsOkDQpUUkFOU1A6T1BBUVVFDQpFTkQ6VkVW\nRU5UDQpCRUdJTjpWRVZFTlQNCkRUU1RBUlQ7VkFMVUU9REFURToyMDE0MDYy\nMA0KRFRFTkQ7VkFMVUU9REFURToyMDE0MDYyMQ0KRFRTVEFNUDoyMDEzMDEw\nM1QxNTU0MjNaDQpVSUQ6aEA5YTA3ZWFkYTBmMTdlMDBhMGJlNTBjOTkwZjAw\nNjlkMmI5NGUxYzBlQGdvb2dsZS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJ\nVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPUFDQ0VQVEVE\nO1gtTlVNLUdVRQ0KIFNUUz0wOm1haWx0bzpjcGtpc3BqOWRwbjZpc3I4NGRr\nNnVyMzljaGduaWczN2U5bm5hczFlZW9uNjZvYmNjbG42OG9iaTVwam11cg0K\nIHI3ZGhpaXNvcmZkayU0MHZpcnR1YWwNCkNMQVNTOlBVQkxJQw0KQ1JFQVRF\nRDoyMDEzMDEwM1QwNjU1NDVaDQpMQVNULU1PRElGSUVEOjIwMTMwMTAzVDA2\nNTU0NVoNClNFUVVFTkNFOjENClNUQVRVUzpDT05GSVJNRUQNClNVTU1BUlk6\nSnVoYW5udXNhYXR0bw0KVFJBTlNQOk9QQVFVRQ0KRU5EOlZFVkVOVA0KQkVH\nSU46VkVWRU5UDQpEVFNUQVJUO1ZBTFVFPURBVEU6MjAxMzA2MjENCkRURU5E\nO1ZBTFVFPURBVEU6MjAxMzA2MjINCkRUU1RBTVA6MjAxMzAxMDNUMTU1NDIz\nWg0KVUlEOmhANWY2MmZmYTkxYTQwY2Q5ZmRlNzk3N2Y0M2NhYWIzYTZiOGYx\nODM1OEBnb29nbGUuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtS\nT0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1BQ0NFUFRFRDtYLU5VTS1H\nVUUNCiBTVFM9MDptYWlsdG86Y3BraXNwajlkcG42aXNyODRkazZ1cjM5Y2hn\nbmlnMzdlOW5uYXMxZWVvbjY2b2JjY2xuNjhvYmk1cGptdXINCiByN2RoaWlz\nb3JmZGslNDB2aXJ0dWFsDQpDTEFTUzpQVUJMSUMNCkNSRUFURUQ6MjAxMzAx\nMDNUMDY1NTQ1Wg0KTEFTVC1NT0RJRklFRDoyMDEzMDEwM1QwNjU1NDVaDQpT\nRVFVRU5DRToxDQpTVEFUVVM6Q09ORklSTUVEDQpTVU1NQVJZOkp1aGFubnVz\nYWF0dG8NClRSQU5TUDpPUEFRVUUNCkVORDpWRVZFTlQNCkJFR0lOOlZFVkVO\nVA0KRFRTVEFSVDtWQUxVRT1EQVRFOjIwMTIxMjI1DQpEVEVORDtWQUxVRT1E\nQVRFOjIwMTIxMjI2DQpEVFNUQU1QOjIwMTMwMTAzVDE1NTQyM1oNClVJRDpo\nQGVlMDJlMmU4MDMwOTE5ODY4N2E1MTE2ZTNjOGJjZWZkNGZmNzA0OTZAZ29v\nZ2xlLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEt\nUEFSVElDSVBBTlQ7UEFSVFNUQVQ9QUNDRVBURUQ7WC1OVU0tR1VFDQogU1RT\nPTA6bWFpbHRvOmNwa2lzcGo5ZHBuNmlzcjg0ZGs2dXIzOWNoZ25pZzM3ZTlu\nbmFzMWVlb242Nm9iY2NsbjY4b2JpNXBqbXVyDQogcjdkaGlpc29yZmRrJTQw\ndmlydHVhbA0KQ0xBU1M6UFVCTElDDQpDUkVBVEVEOjIwMTMwMTAzVDA2NTU0\nNVoNCkxBU1QtTU9ESUZJRUQ6MjAxMzAxMDNUMDY1NTQ1Wg0KU0VRVUVOQ0U6\nMQ0KU1RBVFVTOkNPTkZJUk1FRA0KU1VNTUFSWTpKb3VsdXDDpGl2w6QNClRS\nQU5TUDpPUEFRVUUNCkVORDpWRVZFTlQNCkJFR0lOOlZFVkVOVA0KRFRTVEFS\nVDtWQUxVRT1EQVRFOjIwMTMxMjI1DQpEVEVORDtWQUxVRT1EQVRFOjIwMTMx\nMjI2DQpEVFNUQU1QOjIwMTMwMTAzVDE1NTQyM1oNClVJRDpoQDFjMzJmMDNm\nMjZhYTJiYzA1YWUzOTI0MmNjZDdmZmMyZDkzMjZhNGJAZ29vZ2xlLmNvbQ0K\nQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBB\nTlQ7UEFSVFNUQVQ9QUNDRVBURUQ7WC1OVU0tR1VFDQogU1RTPTA6bWFpbHRv\nOmNwa2lzcGo5ZHBuNmlzcjg0ZGs2dXIzOWNoZ25pZzM3ZTlubmFzMWVlb242\nNm9iY2NsbjY4b2JpNXBqbXVyDQogcjdkaGlpc29yZmRrJTQwdmlydHVhbA0K\nQ0xBU1M6UFVCTElDDQpDUkVBVEVEOjIwMTMwMTAzVDA2NTU0NVoNCkxBU1Qt\nTU9ESUZJRUQ6MjAxMzAxMDNUMDY1NTQ1Wg0KU0VRVUVOQ0U6MQ0KU1RBVFVT\nOkNPTkZJUk1FRA0KU1VNTUFSWTpKb3VsdXDDpGl2w6QNClRSQU5TUDpPUEFR\nVUUNCkVORDpWRVZFTlQNCkJFR0lOOlZFVkVOVA0KRFRTVEFSVDtWQUxVRT1E\nQVRFOjIwMTQxMjI1DQpEVEVORDtWQUxVRT1EQVRFOjIwMTQxMjI2DQpEVFNU\nQU1QOjIwMTMwMTAzVDE1NTQyM1oNClVJRDpoQDAyYmQ1NGJhZDRmOWMxYzBh\nM2FjMTg5ZDU2ZWIwNGUzZjlhZTAxMTRAZ29vZ2xlLmNvbQ0KQVRURU5ERUU7\nQ1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNU\nQVQ9QUNDRVBURUQ7WC1OVU0tR1VFDQogU1RTPTA6bWFpbHRvOmNwa2lzcGo5\nZHBuNmlzcjg0ZGs2dXIzOWNoZ25pZzM3ZTlubmFzMWVlb242Nm9iY2NsbjY4\nb2JpNXBqbXVyDQogcjdkaGlpc29yZmRrJTQwdmlydHVhbA0KQ0xBU1M6UFVC\nTElDDQpDUkVBVEVEOjIwMTMwMTAzVDA2NTU0NVoNCkxBU1QtTU9ESUZJRUQ6\nMjAxMzAxMDNUMDY1NTQ1Wg0KU0VRVUVOQ0U6MQ0KU1RBVFVTOkNPTkZJUk1F\nRA0KU1VNTUFSWTpKb3VsdXDDpGl2w6QNClRSQU5TUDpPUEFRVUUNCkVORDpW\nRVZFTlQNCkJFR0lOOlZFVkVOVA0KRFRTVEFSVDtWQUxVRT1EQVRFOjIwMTQx\nMjI0DQpEVEVORDtWQUxVRT1EQVRFOjIwMTQxMjI1DQpEVFNUQU1QOjIwMTMw\nMTAzVDE1NTQyM1oNClVJRDpoQGQyOWIwMTg2NWY1NmUyYjM3ZjZhMDRhMjI2\nNWZiODI3Nzk2OWQwNGNAZ29vZ2xlLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlO\nRElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9QUNDRVBU\nRUQ7WC1OVU0tR1VFDQogU1RTPTA6bWFpbHRvOmNwa2lzcGo5ZHBuNmlzcjg0\nZGs2dXIzOWNoZ25pZzM3ZTlubmFzMWVlb242Nm9iY2NsbjY4b2JpNXBqbXVy\nDQogcjdkaGlpc29yZmRrJTQwdmlydHVhbA0KQ0xBU1M6UFVCTElDDQpDUkVB\nVEVEOjIwMTMwMTAzVDA2NTU0NVoNCkxBU1QtTU9ESUZJRUQ6MjAxMzAxMDNU\nMDY1NTQ1Wg0KU0VRVUVOQ0U6MQ0KU1RBVFVTOkNPTkZJUk1FRA0KU1VNTUFS\nWTpKb3VsdWFhdHRvDQpUUkFOU1A6T1BBUVVFDQpFTkQ6VkVWRU5UDQpCRUdJ\nTjpWRVZFTlQNCkRUU1RBUlQ7VkFMVUU9REFURToyMDEyMTIyNA0KRFRFTkQ7\nVkFMVUU9REFURToyMDEyMTIyNQ0KRFRTVEFNUDoyMDEzMDEwM1QxNTU0MjNa\nDQpVSUQ6aEA4ZGVjY2I3OTg1NzI0ZmIzMDg2MmZmZmM1NmU5YmViMzI5Nzcy\nOWI1QGdvb2dsZS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JP\nTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPUFDQ0VQVEVEO1gtTlVNLUdV\nRQ0KIFNUUz0wOm1haWx0bzpjcGtpc3BqOWRwbjZpc3I4NGRrNnVyMzljaGdu\naWczN2U5bm5hczFlZW9uNjZvYmNjbG42OG9iaTVwam11cg0KIHI3ZGhpaXNv\ncmZkayU0MHZpcnR1YWwNCkNMQVNTOlBVQkxJQw0KQ1JFQVRFRDoyMDEzMDEw\nM1QwNjU1NDVaDQpMQVNULU1PRElGSUVEOjIwMTMwMTAzVDA2NTU0NVoNClNF\nUVVFTkNFOjENClNUQVRVUzpDT05GSVJNRUQNClNVTU1BUlk6Sm91bHVhYXR0\nbw0KVFJBTlNQOk9QQVFVRQ0KRU5EOlZFVkVOVA0KQkVHSU46VkVWRU5UDQpE\nVFNUQVJUO1ZBTFVFPURBVEU6MjAxMzEyMjQNCkRURU5EO1ZBTFVFPURBVEU6\nMjAxMzEyMjUNCkRUU1RBTVA6MjAxMzAxMDNUMTU1NDIzWg0KVUlEOmhAMTM0\nMjMyMzc5ZmU4NGQ0Yjc0OWE2MmE0MGJiYmRlOGQ2YjQ4M2FkYUBnb29nbGUu\nY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJU\nSUNJUEFOVDtQQVJUU1RBVD1BQ0NFUFRFRDtYLU5VTS1HVUUNCiBTVFM9MDpt\nYWlsdG86Y3BraXNwajlkcG42aXNyODRkazZ1cjM5Y2hnbmlnMzdlOW5uYXMx\nZWVvbjY2b2JjY2xuNjhvYmk1cGptdXINCiByN2RoaWlzb3JmZGslNDB2aXJ0\ndWFsDQpDTEFTUzpQVUJMSUMNCkNSRUFURUQ6MjAxMzAxMDNUMDY1NTQ1Wg0K\nTEFTVC1NT0RJRklFRDoyMDEzMDEwM1QwNjU1NDVaDQpTRVFVRU5DRToxDQpT\nVEFUVVM6Q09ORklSTUVEDQpTVU1NQVJZOkpvdWx1YWF0dG8NClRSQU5TUDpP\nUEFRVUUNCkVORDpWRVZFTlQNCkJFR0lOOlZFVkVOVA0KRFRTVEFSVDtWQUxV\nRT1EQVRFOjIwMTQxMjA2DQpEVEVORDtWQUxVRT1EQVRFOjIwMTQxMjA3DQpE\nVFNUQU1QOjIwMTMwMTAzVDE1NTQyM1oNClVJRDpoQGM0ZGFiYTYyMmM0Yjkw\nOWU4ZDBhMTg0M2QyY2NkNDYxNTRiODVhYTRAZ29vZ2xlLmNvbQ0KQVRURU5E\nRUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFS\nVFNUQVQ9QUNDRVBURUQ7WC1OVU0tR1VFDQogU1RTPTA6bWFpbHRvOmNwa2lz\ncGo5ZHBuNmlzcjg0ZGs2dXIzOWNoZ25pZzM3ZTlubmFzMWVlb242Nm9iY2Ns\nbjY4b2JpNXBqbXVyDQogcjdkaGlpc29yZmRrJTQwdmlydHVhbA0KQ0xBU1M6\nUFVCTElDDQpDUkVBVEVEOjIwMTMwMTAzVDA2NTU0NVoNCkxBU1QtTU9ESUZJ\nRUQ6MjAxMzAxMDNUMDY1NTQ1Wg0KU0VRVUVOQ0U6MQ0KU1RBVFVTOkNPTkZJ\nUk1FRA0KU1VNTUFSWTpJdHNlbsOkaXN5eXNww6RpdsOkDQpUUkFOU1A6T1BB\nUVVFDQpFTkQ6VkVWRU5UDQpCRUdJTjpWRVZFTlQNCkRUU1RBUlQ7VkFMVUU9\nREFURToyMDEyMTIwNg0KRFRFTkQ7VkFMVUU9REFURToyMDEyMTIwNw0KRFRT\nVEFNUDoyMDEzMDEwM1QxNTU0MjNaDQpVSUQ6aEAxOTMxNGMzZjNmYjZmOGM4\nMTI2ODc0MzZiYzM4ZjljNDI3OWUyYTM3QGdvb2dsZS5jb20NCkFUVEVOREVF\nO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRT\nVEFUPUFDQ0VQVEVEO1gtTlVNLUdVRQ0KIFNUUz0wOm1haWx0bzpjcGtpc3Bq\nOWRwbjZpc3I4NGRrNnVyMzljaGduaWczN2U5bm5hczFlZW9uNjZvYmNjbG42\nOG9iaTVwam11cg0KIHI3ZGhpaXNvcmZkayU0MHZpcnR1YWwNCkNMQVNTOlBV\nQkxJQw0KQ1JFQVRFRDoyMDEzMDEwM1QwNjU1NDVaDQpMQVNULU1PRElGSUVE\nOjIwMTMwMTAzVDA2NTU0NVoNClNFUVVFTkNFOjENClNUQVRVUzpDT05GSVJN\nRUQNClNVTU1BUlk6SXRzZW7DpGlzeXlzcMOkaXbDpA0KVFJBTlNQOk9QQVFV\nRQ0KRU5EOlZFVkVOVA0KQkVHSU46VkVWRU5UDQpEVFNUQVJUO1ZBTFVFPURB\nVEU6MjAxMzEyMDYNCkRURU5EO1ZBTFVFPURBVEU6MjAxMzEyMDcNCkRUU1RB\nTVA6MjAxMzAxMDNUMTU1NDIzWg0KVUlEOmhAMDlkOWZlMTNiNzE4OTAzMzQz\nOWQ1YWI5MzM2YmMwY2JlMGMzZGJhZUBnb29nbGUuY29tDQpBVFRFTkRFRTtD\nVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RB\nVD1BQ0NFUFRFRDtYLU5VTS1HVUUNCiBTVFM9MDptYWlsdG86Y3BraXNwajlk\ncG42aXNyODRkazZ1cjM5Y2hnbmlnMzdlOW5uYXMxZWVvbjY2b2JjY2xuNjhv\nYmk1cGptdXINCiByN2RoaWlzb3JmZGslNDB2aXJ0dWFsDQpDTEFTUzpQVUJM\nSUMNCkNSRUFURUQ6MjAxMzAxMDNUMDY1NTQ1Wg0KTEFTVC1NT0RJRklFRDoy\nMDEzMDEwM1QwNjU1NDVaDQpTRVFVRU5DRToxDQpTVEFUVVM6Q09ORklSTUVE\nDQpTVU1NQVJZOkl0c2Vuw6Rpc3l5c3DDpGl2w6QNClRSQU5TUDpPUEFRVUUN\nCkVORDpWRVZFTlQNCkJFR0lOOlZFVkVOVA0KRFRTVEFSVDtWQUxVRT1EQVRF\nOjIwMTMwNTE5DQpEVEVORDtWQUxVRT1EQVRFOjIwMTMwNTIwDQpEVFNUQU1Q\nOjIwMTMwMTAzVDE1NTQyM1oNClVJRDpoQGM5NTc4MTJhN2JhMDI3Yjk4Zjgy\nODdhMzk3YTkzMDg5ZGI2ZDUxYjBAZ29vZ2xlLmNvbQ0KQVRURU5ERUU7Q1VU\nWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9\nQUNDRVBURUQ7WC1OVU0tR1VFDQogU1RTPTA6bWFpbHRvOmNwa2lzcGo5ZHBu\nNmlzcjg0ZGs2dXIzOWNoZ25pZzM3ZTlubmFzMWVlb242Nm9iY2NsbjY4b2Jp\nNXBqbXVyDQogcjdkaGlpc29yZmRrJTQwdmlydHVhbA0KQ0xBU1M6UFVCTElD\nDQpDUkVBVEVEOjIwMTMwMTAzVDA2NTU0NVoNCkxBU1QtTU9ESUZJRUQ6MjAx\nMzAxMDNUMDY1NTQ1Wg0KU0VRVUVOQ0U6MQ0KU1RBVFVTOkNPTkZJUk1FRA0K\nU1VNTUFSWTpIZWxsdW50YWkNClRSQU5TUDpPUEFRVUUNCkVORDpWRVZFTlQN\nCkJFR0lOOlZFVkVOVA0KRFRTVEFSVDtWQUxVRT1EQVRFOjIwMTQwNjA4DQpE\nVEVORDtWQUxVRT1EQVRFOjIwMTQwNjA5DQpEVFNUQU1QOjIwMTMwMTAzVDE1\nNTQyM1oNClVJRDpoQDdmM2IxNTNlODUxNTkzMjk0ZGIzMDNlNmVjYjFmMzE0\nZDhjZTU2OTBAZ29vZ2xlLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURV\nQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9QUNDRVBURUQ7WC1O\nVU0tR1VFDQogU1RTPTA6bWFpbHRvOmNwa2lzcGo5ZHBuNmlzcjg0ZGs2dXIz\nOWNoZ25pZzM3ZTlubmFzMWVlb242Nm9iY2NsbjY4b2JpNXBqbXVyDQogcjdk\naGlpc29yZmRrJTQwdmlydHVhbA0KQ0xBU1M6UFVCTElDDQpDUkVBVEVEOjIw\nMTMwMTAzVDA2NTU0NVoNCkxBU1QtTU9ESUZJRUQ6MjAxMzAxMDNUMDY1NTQ1\nWg0KU0VRVUVOQ0U6MQ0KU1RBVFVTOkNPTkZJUk1FRA0KU1VNTUFSWTpIZWxs\ndW50YWkNClRSQU5TUDpPUEFRVUUNCkVORDpWRVZFTlQNCkJFR0lOOlZFVkVO\nVA0KRFRTVEFSVDtWQUxVRT1EQVRFOjIwMTQwNTI5DQpEVEVORDtWQUxVRT1E\nQVRFOjIwMTQwNTMwDQpEVFNUQU1QOjIwMTMwMTAzVDE1NTQyM1oNClVJRDpo\nQDkwNmY2MDQ2MjkxMTMwNDcwMTIzMzI1Mzg4OWRkOTAwNTAzYzk1MTdAZ29v\nZ2xlLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEt\nUEFSVElDSVBBTlQ7UEFSVFNUQVQ9QUNDRVBURUQ7WC1OVU0tR1VFDQogU1RT\nPTA6bWFpbHRvOmNwa2lzcGo5ZHBuNmlzcjg0ZGs2dXIzOWNoZ25pZzM3ZTlu\nbmFzMWVlb242Nm9iY2NsbjY4b2JpNXBqbXVyDQogcjdkaGlpc29yZmRrJTQw\ndmlydHVhbA0KQ0xBU1M6UFVCTElDDQpDUkVBVEVEOjIwMTMwMTAzVDA2NTU0\nNVoNCkxBU1QtTU9ESUZJRUQ6MjAxMzAxMDNUMDY1NTQ1Wg0KU0VRVUVOQ0U6\nMQ0KU1RBVFVTOkNPTkZJUk1FRA0KU1VNTUFSWTpIZWxhdG9yc3RhaQ0KVFJB\nTlNQOk9QQVFVRQ0KRU5EOlZFVkVOVA0KQkVHSU46VkVWRU5UDQpEVFNUQVJU\nO1ZBTFVFPURBVEU6MjAxMzA1MDkNCkRURU5EO1ZBTFVFPURBVEU6MjAxMzA1\nMTANCkRUU1RBTVA6MjAxMzAxMDNUMTU1NDIzWg0KVUlEOmhANzkwNDk2NWUy\nZTVjNjQ5MGI3MDU0MGMzYzVlMjc0OGRkZGE5NjQwMkBnb29nbGUuY29tDQpB\nVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFO\nVDtQQVJUU1RBVD1BQ0NFUFRFRDtYLU5VTS1HVUUNCiBTVFM9MDptYWlsdG86\nY3BraXNwajlkcG42aXNyODRkazZ1cjM5Y2hnbmlnMzdlOW5uYXMxZWVvbjY2\nb2JjY2xuNjhvYmk1cGptdXINCiByN2RoaWlzb3JmZGslNDB2aXJ0dWFsDQpD\nTEFTUzpQVUJMSUMNCkNSRUFURUQ6MjAxMzAxMDNUMDY1NTQ1Wg0KTEFTVC1N\nT0RJRklFRDoyMDEzMDEwM1QwNjU1NDVaDQpTRVFVRU5DRToxDQpTVEFUVVM6\nQ09ORklSTUVEDQpTVU1NQVJZOkhlbGF0b3JzdGFpDQpUUkFOU1A6T1BBUVVF\nDQpFTkQ6VkVWRU5UDQpCRUdJTjpWRVZFTlQNCkRUU1RBUlQ7VkFMVUU9REFU\nRToyMDEzMDQwMQ0KRFRFTkQ7VkFMVUU9REFURToyMDEzMDQwMg0KRFRTVEFN\nUDoyMDEzMDEwM1QxNTU0MjNaDQpVSUQ6aEA5ZmE4MDdjMGQ3OTEzYmY3YzQz\nNDJhMTQ1ZjE2YzAyNDI3MjgzYTc1QGdvb2dsZS5jb20NCkFUVEVOREVFO0NV\nVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFU\nPUFDQ0VQVEVEO1gtTlVNLUdVRQ0KIFNUUz0wOm1haWx0bzpjcGtpc3BqOWRw\nbjZpc3I4NGRrNnVyMzljaGduaWczN2U5bm5hczFlZW9uNjZvYmNjbG42OG9i\naTVwam11cg0KIHI3ZGhpaXNvcmZkayU0MHZpcnR1YWwNCkNMQVNTOlBVQkxJ\nQw0KQ1JFQVRFRDoyMDEzMDEwM1QwNjU1NDVaDQpMQVNULU1PRElGSUVEOjIw\nMTMwMTAzVDA2NTU0NVoNClNFUVVFTkNFOjENClNUQVRVUzpDT05GSVJNRUQN\nClNVTU1BUlk6Mi4gcMOkw6RzacOkaXNww6RpdsOkDQpUUkFOU1A6T1BBUVVF\nDQpFTkQ6VkVWRU5UDQpCRUdJTjpWRVZFTlQNCkRUU1RBUlQ7VkFMVUU9REFU\nRToyMDE0MDQyMQ0KRFRFTkQ7VkFMVUU9REFURToyMDE0MDQyMg0KRFRTVEFN\nUDoyMDEzMDEwM1QxNTU0MjNaDQpVSUQ6aEA4MDhmYmQ3NGI1ZWNjMDNmMmFi\nMDIyYzhkZmQyMzUwNDAwYjQ3YmIxQGdvb2dsZS5jb20NCkFUVEVOREVFO0NV\nVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFU\nPUFDQ0VQVEVEO1gtTlVNLUdVRQ0KIFNUUz0wOm1haWx0bzpjcGtpc3BqOWRw\nbjZpc3I4NGRrNnVyMzljaGduaWczN2U5bm5hczFlZW9uNjZvYmNjbG42OG9i\naTVwam11cg0KIHI3ZGhpaXNvcmZkayU0MHZpcnR1YWwNCkNMQVNTOlBVQkxJ\nQw0KQ1JFQVRFRDoyMDEzMDEwM1QwNjU1NDVaDQpMQVNULU1PRElGSUVEOjIw\nMTMwMTAzVDA2NTU0NVoNClNFUVVFTkNFOjENClNUQVRVUzpDT05GSVJNRUQN\nClNVTU1BUlk6Mi4gcMOkw6RzacOkaXNww6RpdsOkDQpUUkFOU1A6T1BBUVVF\nDQpFTkQ6VkVWRU5UDQpFTkQ6VkNBTEVOREFSDQo=\n"
CALENDAR_STRING = Base64::decode64(ENCODED_DATA)

describe HolidayCalendar do
  before(:each) do
    @cal = HolidayCalendar::HolidayCalendar.new
    @cal.stub(read_calendar: CALENDAR_STRING)
  end

  it "should mark new year as holiday" do
    @cal.holiday?(Date.new(2013, 1, 1)).should be_true
  end

  it "should NOT mark monday 2013-01-07 as holiday" do
    @cal.holiday?(Date.new(2013, 1, 7)).should be_false
  end

  it "should return number of weekdays between given days with no holidays" do
    d1, d2 = [[4, 22], [4, 25]].map { |m, d| Date.new(2013, m, d) }
    @cal.weekdays_between(d1, d2).should == 3
  end

  it "should return number of weekdays between given days with a holiday" do
    d1, d2 = [[4, 25], [5, 6]].map { |m, d| Date.new(2013, m, d) }
    @cal.weekdays_between(d1, d2).should == 6
  end

  it "should return negative day count if second date is before first" do
    d1, d2 = [[4, 25], [5, 6]].map { |m, d| Date.new(2013, m, d) }
    @cal.weekdays_between(d2, d1).should == -6
  end

end
